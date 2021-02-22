Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC8C32113B
	for <lists+linux-arch@lfdr.de>; Mon, 22 Feb 2021 08:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhBVHPv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Feb 2021 02:15:51 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:63406 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229952AbhBVHPc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Feb 2021 02:15:32 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613978107; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=bvL7IeBa4MpEPKdjMB22D7Uk+WRT/u8hco4xQMVOEWY=;
 b=GoTNULAjSx0NDk2YA8k31s1AiWxe3pQ/+q/sWH+h9GGQES3EvrgCs51df8Iu3e2JEPTXECcA
 9tXYmRQ1/5CLuWYGjSlg2X8b1rOjqQXNJ6DQr85lK1jGujuAta772SX8yA11gA9zcM/nlx6p
 qF2CEj6/qpWBB5jm4jmfa4K67fM=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI5MDNlZiIsICJsaW51eC1hcmNoQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 603359d70ccf3cf226b46c5c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Feb 2021 07:14:31
 GMT
Sender: pnagar=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C17E8C43467; Mon, 22 Feb 2021 07:14:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pnagar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 537E4C433C6;
        Mon, 22 Feb 2021 07:14:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 22 Feb 2021 12:44:29 +0530
From:   pnagar@codeaurora.org
To:     Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>, casey@schaufler-ca.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Howells <dhowells@redhat.com>, ojeda@kernel.org,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        nmardana@codeaurora.org, johan@kernel.org,
        Joe Perches <joe@perches.com>, Jessica Yu <jeyu@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RTIC: selinux: ARM64: Move selinux_state to a separate
 page
In-Reply-To: <CAMj1kXG_qj0A5r+rRnGdcwjomqJUSQPw6aNYyPbSVA8Fr=RjyA@mail.gmail.com>
References: <1613470672-3069-1-git-send-email-pnagar@codeaurora.org>
 <20210217094205.GA3570@willie-the-truck>
 <CAMj1kXG_qj0A5r+rRnGdcwjomqJUSQPw6aNYyPbSVA8Fr=RjyA@mail.gmail.com>
Message-ID: <db7be4b7c31828d559ad4b1f4a93b76e@codeaurora.org>
X-Sender: pnagar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2021-02-17 15:23, Ard Biesheuvel wrote:
> On Wed, 17 Feb 2021 at 10:42, Will Deacon <will@kernel.org> wrote:
>> 
>> [Please include arm64 and kvm folks for threads involving the stage-2 
>> MMU]
>> 
>> On Tue, Feb 16, 2021 at 03:47:52PM +0530, Preeti Nagar wrote:
>> > The changes introduce a new security feature, RunTime Integrity Check
>> > (RTIC), designed to protect Linux Kernel at runtime. The motivation
>> > behind these changes is:
>> > 1. The system protection offered by Security Enhancements(SE) for
>> > Android relies on the assumption of kernel integrity. If the kernel
>> > itself is compromised (by a perhaps as yet unknown future vulnerability),
>> > SE for Android security mechanisms could potentially be disabled and
>> > rendered ineffective.
>> > 2. Qualcomm Snapdragon devices use Secure Boot, which adds cryptographic
>> > checks to each stage of the boot-up process, to assert the authenticity
>> > of all secure software images that the device executes.  However, due to
>> > various vulnerabilities in SW modules, the integrity of the system can be
>> > compromised at any time after device boot-up, leading to un-authorized
>> > SW executing.
>> >
>> > The feature's idea is to move some sensitive kernel structures to a
>> > separate page and monitor further any unauthorized changes to these,
>> > from higher Exception Levels using stage 2 MMU. Moving these to a
>> > different page will help avoid getting page faults from un-related data.
>> > The mechanism we have been working on removes the write permissions for
>> > HLOS in the stage 2 page tables for the regions to be monitored, such
>> > that any modification attempts to these will lead to faults being
>> > generated and handled by handlers. If the protected assets are moved to
>> > a separate page, faults will be generated corresponding to change attempts
>> > to these assets only. If not moved to a separate page, write attempts to
>> > un-related data present on the monitored pages will also be generated.
>> >
>> > Using this feature, some sensitive variables of the kernel which are
>> > initialized after init or are updated rarely can also be protected from
>> > simple overwrites and attacks trying to modify these.
>> 
>> Although I really like the idea of using stage-2 to protect the 
>> kernel, I
>> think the approach you outline here is deeply flawed. Identifying 
>> "sensitive
>> variables" of the kernel to protect is subjective and doesn't scale.
>> Furthermore, the triaging of what constitues a valid access is notably
>> absent from your description and is assumedly implemented in an opaque 
>> blob
>> at EL2.
>> 
>> I think a better approach would be along the lines of:
>> 
>>   1. Introduce the protection at stage-1 (like we already have for 
>> mapping
>>      e.g. the kernel text R/O)
>> 
>>   2. Implement the handlers in the kernel, so the heuristics are 
>> clear.
>> 
>>   3. Extend this to involve KVM, so that the host can manage its own
>>      stage-2 to firm-up the stage-1 protections.
>> 
> 
> Agree here. Making an arbitrary set of data structures r/o behind the
> OS's back doesn't seem like an easy thing to maintain or reason about,
> especially if this r/o-ness is only enforced on a tiny subset of
> devices. If something needs to be writable only at boot, we have
> __ro_after_init, and having hypervisor assisted enforcement of /that/
> might be a worthwhile thing to consider, including perhaps ways to do
> controlled patching of this region at runtime.
> 

Thank you for the suggestions. We will look into the possibility of 
protection
of __ro_after_init and controlled updates to these. I understand, if 
this can be
made generic as Will also suggested, it might be more useful and easy to 
scale
and maintain.

>> I also think we should avoid tying this to specific data structures.
>> Rather, we should introduce a mechanism to make arbitrary data 
>> read-only.
>> 
>> I've CC'd Ard and Marc, as I think they've both been thinking about 
>> this
>> sort of thing recently as well.
>> 
>> Will
