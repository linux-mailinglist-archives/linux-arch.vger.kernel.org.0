Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD4C31D767
	for <lists+linux-arch@lfdr.de>; Wed, 17 Feb 2021 11:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbhBQKRz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Feb 2021 05:17:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:57400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232166AbhBQKQ0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 17 Feb 2021 05:16:26 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09AFA60C40;
        Wed, 17 Feb 2021 10:15:45 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lCJry-00EZer-Rm; Wed, 17 Feb 2021 10:15:42 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 17 Feb 2021 10:15:42 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>, Preeti Nagar <pnagar@codeaurora.org>
Cc:     ardb@kernel.org, arnd@arndb.de, jmorris@namei.org,
        serge@hallyn.com, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-arch@vger.kernel.org, casey@schaufler-ca.com,
        ndesaulniers@google.com, dhowells@redhat.com, ojeda@kernel.org,
        psodagud@codeaurora.org, nmardana@codeaurora.org,
        rkavati@codeaurora.org, vsekhar@codeaurora.org,
        mreichar@codeaurora.org, johan@kernel.org, joe@perches.com,
        jeyu@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RTIC: selinux: ARM64: Move selinux_state to a separate
 page
In-Reply-To: <20210217094205.GA3570@willie-the-truck>
References: <1613470672-3069-1-git-send-email-pnagar@codeaurora.org>
 <20210217094205.GA3570@willie-the-truck>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <09bd49a4d8fcb1bebaa4f40fd5c6eac3@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: will@kernel.org, pnagar@codeaurora.org, ardb@kernel.org, arnd@arndb.de, jmorris@namei.org, serge@hallyn.com, paul@paul-moore.com, stephen.smalley.work@gmail.com, eparis@parisplace.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-arch@vger.kernel.org, casey@schaufler-ca.com, ndesaulniers@google.com, dhowells@redhat.com, ojeda@kernel.org, psodagud@codeaurora.org, nmardana@codeaurora.org, rkavati@codeaurora.org, vsekhar@codeaurora.org, mreichar@codeaurora.org, johan@kernel.org, joe@perches.com, jeyu@kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2021-02-17 09:42, Will Deacon wrote:
> [Please include arm64 and kvm folks for threads involving the stage-2 
> MMU]
> 
> On Tue, Feb 16, 2021 at 03:47:52PM +0530, Preeti Nagar wrote:
>> The changes introduce a new security feature, RunTime Integrity Check
>> (RTIC), designed to protect Linux Kernel at runtime. The motivation
>> behind these changes is:
>> 1. The system protection offered by Security Enhancements(SE) for
>> Android relies on the assumption of kernel integrity. If the kernel
>> itself is compromised (by a perhaps as yet unknown future 
>> vulnerability),
>> SE for Android security mechanisms could potentially be disabled and
>> rendered ineffective.
>> 2. Qualcomm Snapdragon devices use Secure Boot, which adds 
>> cryptographic
>> checks to each stage of the boot-up process, to assert the 
>> authenticity
>> of all secure software images that the device executes.  However, due 
>> to
>> various vulnerabilities in SW modules, the integrity of the system can 
>> be
>> compromised at any time after device boot-up, leading to un-authorized
>> SW executing.
>> 
>> The feature's idea is to move some sensitive kernel structures to a
>> separate page and monitor further any unauthorized changes to these,
>> from higher Exception Levels using stage 2 MMU. Moving these to a
>> different page will help avoid getting page faults from un-related 
>> data.
>> The mechanism we have been working on removes the write permissions 
>> for
>> HLOS in the stage 2 page tables for the regions to be monitored, such
>> that any modification attempts to these will lead to faults being
>> generated and handled by handlers. If the protected assets are moved 
>> to
>> a separate page, faults will be generated corresponding to change 
>> attempts
>> to these assets only. If not moved to a separate page, write attempts 
>> to
>> un-related data present on the monitored pages will also be generated.
>> 
>> Using this feature, some sensitive variables of the kernel which are
>> initialized after init or are updated rarely can also be protected 
>> from
>> simple overwrites and attacks trying to modify these.
> 
> Although I really like the idea of using stage-2 to protect the kernel, 
> I
> think the approach you outline here is deeply flawed. Identifying 
> "sensitive
> variables" of the kernel to protect is subjective and doesn't scale.
> Furthermore, the triaging of what constitues a valid access is notably
> absent from your description and is assumedly implemented in an opaque 
> blob
> at EL2.
> 
> I think a better approach would be along the lines of:
> 
>   1. Introduce the protection at stage-1 (like we already have for 
> mapping
>      e.g. the kernel text R/O)
> 
>   2. Implement the handlers in the kernel, so the heuristics are clear.
> 
>   3. Extend this to involve KVM, so that the host can manage its own
>      stage-2 to firm-up the stage-1 protections.

+1 on that. Even if, as I suspect, this is targeting some unspecified
hypervisor that is not KVM, the first course of action should be for
this to be implemented in the kernel's own hypervisor first so that
anyone can review understand what is at play.

Thanks,

          M.
-- 
Jazz is not dead. It just smells funny...
