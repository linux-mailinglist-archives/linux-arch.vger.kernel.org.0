Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078393213A7
	for <lists+linux-arch@lfdr.de>; Mon, 22 Feb 2021 11:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhBVKDV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Feb 2021 05:03:21 -0500
Received: from jptosegrel01.sonyericsson.com ([124.215.201.71]:15340 "EHLO
        JPTOSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230417AbhBVKCY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Feb 2021 05:02:24 -0500
X-Greylist: delayed 646 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Feb 2021 05:02:08 EST
Subject: Re: [PATCH] RTIC: selinux: ARM64: Move selinux_state to a separate
 page
To:     Will Deacon <will@kernel.org>,
        Preeti Nagar <pnagar@codeaurora.org>, <maz@kernel.org>,
        <ardb@kernel.org>
CC:     <arnd@arndb.de>, <jmorris@namei.org>, <serge@hallyn.com>,
        <paul@paul-moore.com>, <stephen.smalley.work@gmail.com>,
        <eparis@parisplace.org>, <linux-security-module@vger.kernel.org>,
        <selinux@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <casey@schaufler-ca.com>, <ndesaulniers@google.com>,
        <dhowells@redhat.com>, <ojeda@kernel.org>,
        <psodagud@codeaurora.org>, <nmardana@codeaurora.org>,
        <rkavati@codeaurora.org>, <vsekhar@codeaurora.org>,
        <mreichar@codeaurora.org>, <johan@kernel.org>, <joe@perches.com>,
        <jeyu@kernel.org>, <linux-kernel@vger.kernel.org>
References: <1613470672-3069-1-git-send-email-pnagar@codeaurora.org>
 <20210217094205.GA3570@willie-the-truck>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <5f6b5d38-266e-12f7-8e55-07fe794fbf97@sony.com>
Date:   Mon, 22 Feb 2021 10:50:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210217094205.GA3570@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=fqOim2wf c=1 sm=1 tr=0 a=9drRLWArJOlETflmpfiyCA==:117 a=IkcTkHD0fZMA:10 a=qa6Q16uM49sA:10 a=aMTo-Due3bUgzeKeeW4A:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/17/21 10:42 AM, Will Deacon wrote:
> [Please include arm64 and kvm folks for threads involving the stage-2 MMU]
>
> On Tue, Feb 16, 2021 at 03:47:52PM +0530, Preeti Nagar wrote:
>> The changes introduce a new security feature, RunTime Integrity Check
>> (RTIC), designed to protect Linux Kernel at runtime. The motivation
>> behind these changes is:
>> 1. The system protection offered by Security Enhancements(SE) for
>> Android relies on the assumption of kernel integrity. If the kernel
>> itself is compromised (by a perhaps as yet unknown future vulnerability),
>> SE for Android security mechanisms could potentially be disabled and
>> rendered ineffective.
>> 2. Qualcomm Snapdragon devices use Secure Boot, which adds cryptographic
>> checks to each stage of the boot-up process, to assert the authenticity
>> of all secure software images that the device executes.  However, due to
>> various vulnerabilities in SW modules, the integrity of the system can be
>> compromised at any time after device boot-up, leading to un-authorized
>> SW executing.
>>
>> The feature's idea is to move some sensitive kernel structures to a
>> separate page and monitor further any unauthorized changes to these,
>> from higher Exception Levels using stage 2 MMU. Moving these to a
>> different page will help avoid getting page faults from un-related data.
>> The mechanism we have been working on removes the write permissions for
>> HLOS in the stage 2 page tables for the regions to be monitored, such
>> that any modification attempts to these will lead to faults being
>> generated and handled by handlers. If the protected assets are moved to
>> a separate page, faults will be generated corresponding to change attempts
>> to these assets only. If not moved to a separate page, write attempts to
>> un-related data present on the monitored pages will also be generated.
>>
>> Using this feature, some sensitive variables of the kernel which are
>> initialized after init or are updated rarely can also be protected from
>> simple overwrites and attacks trying to modify these.
> Although I really like the idea of using stage-2 to protect the kernel, I
> think the approach you outline here is deeply flawed. Identifying "sensitive
> variables" of the kernel to protect is subjective and doesn't scale.
> Furthermore, the triaging of what constitues a valid access is notably
> absent from your description and is assumedly implemented in an opaque blob
> at EL2.
>
> I think a better approach would be along the lines of:
>
>   1. Introduce the protection at stage-1 (like we already have for mapping
>      e.g. the kernel text R/O)

Will that really solve the problem? There is a lot of caches that are used
to resolve policy data in selinux, and this caches will not be protected.
If you can manipulate kernel data you can do cache poisoning.


>   2. Implement the handlers in the kernel, so the heuristics are clear.
>
>   3. Extend this to involve KVM, so that the host can manage its own
>      stage-2 to firm-up the stage-1 protections.
>
> I also think we should avoid tying this to specific data structures.
> Rather, we should introduce a mechanism to make arbitrary data read-only.
>
> I've CC'd Ard and Marc, as I think they've both been thinking about this
> sort of thing recently as well.
>
> Will


