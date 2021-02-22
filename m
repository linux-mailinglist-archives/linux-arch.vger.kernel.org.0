Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B543321017
	for <lists+linux-arch@lfdr.de>; Mon, 22 Feb 2021 05:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhBVE7h (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 21 Feb 2021 23:59:37 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:42122 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230064AbhBVE7f (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 21 Feb 2021 23:59:35 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613969951; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=eMp/Oi18EvtK5YOknhy++/LedAfl59fyqLiaB5bvtI4=;
 b=kVna8xnlQIC2dIfySXDmbIpMJjxJ8mNhnBN8opNYlx9kcvU3cmOls9GgkOhtlrtfP8SdKD8o
 pamX7H6vQraBKYHoiDILT/zU7FkUmZsSpj/1scFUB9Jthx6lSthyVn84PT+dWG5+eMQKd7S3
 Zw8SdpEofYYYcWH0uOHsVR3zb9s=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI5MDNlZiIsICJsaW51eC1hcmNoQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 60333a027237f827dcf20c3d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Feb 2021 04:58:42
 GMT
Sender: pnagar=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 94EF4C43468; Mon, 22 Feb 2021 04:58:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pnagar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 517FEC433CA;
        Mon, 22 Feb 2021 04:58:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 22 Feb 2021 10:28:41 +0530
From:   pnagar@codeaurora.org
To:     Marc Zyngier <maz@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Will Deacon <will@kernel.org>, ardb@kernel.org, arnd@arndb.de,
        jmorris@namei.org, serge@hallyn.com, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-arch@vger.kernel.org, casey@schaufler-ca.com,
        ndesaulniers@google.com, dhowells@redhat.com, ojeda@kernel.org,
        psodagud@codeaurora.org, nmardana@codeaurora.org, johan@kernel.org,
        joe@perches.com, jeyu@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RTIC: selinux: ARM64: Move selinux_state to a separate
 page
In-Reply-To: <09bd49a4d8fcb1bebaa4f40fd5c6eac3@kernel.org>
References: <1613470672-3069-1-git-send-email-pnagar@codeaurora.org>
 <20210217094205.GA3570@willie-the-truck>
 <09bd49a4d8fcb1bebaa4f40fd5c6eac3@kernel.org>
Message-ID: <5f33e59bf9c01ed5c33a9c3cbe277615@codeaurora.org>
X-Sender: pnagar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2021-02-17 15:45, Marc Zyngier wrote:
> On 2021-02-17 09:42, Will Deacon wrote:
>> [Please include arm64 and kvm folks for threads involving the stage-2 
>> MMU]
>> 
>> On Tue, Feb 16, 2021 at 03:47:52PM +0530, Preeti Nagar wrote:
>>> The changes introduce a new security feature, RunTime Integrity Check
>>> (RTIC), designed to protect Linux Kernel at runtime. The motivation
>>> behind these changes is:
>>> 1. The system protection offered by Security Enhancements(SE) for
>>> Android relies on the assumption of kernel integrity. If the kernel
>>> itself is compromised (by a perhaps as yet unknown future 
>>> vulnerability),
>>> SE for Android security mechanisms could potentially be disabled and
>>> rendered ineffective.
>>> 2. Qualcomm Snapdragon devices use Secure Boot, which adds 
>>> cryptographic
>>> checks to each stage of the boot-up process, to assert the 
>>> authenticity
>>> of all secure software images that the device executes.  However, due 
>>> to
>>> various vulnerabilities in SW modules, the integrity of the system 
>>> can be
>>> compromised at any time after device boot-up, leading to 
>>> un-authorized
>>> SW executing.
>>> 
>>> The feature's idea is to move some sensitive kernel structures to a
>>> separate page and monitor further any unauthorized changes to these,
>>> from higher Exception Levels using stage 2 MMU. Moving these to a
>>> different page will help avoid getting page faults from un-related 
>>> data.
>>> The mechanism we have been working on removes the write permissions 
>>> for
>>> HLOS in the stage 2 page tables for the regions to be monitored, such
>>> that any modification attempts to these will lead to faults being
>>> generated and handled by handlers. If the protected assets are moved 
>>> to
>>> a separate page, faults will be generated corresponding to change 
>>> attempts
>>> to these assets only. If not moved to a separate page, write attempts 
>>> to
>>> un-related data present on the monitored pages will also be 
>>> generated.
>>> 
>>> Using this feature, some sensitive variables of the kernel which are
>>> initialized after init or are updated rarely can also be protected 
>>> from
>>> simple overwrites and attacks trying to modify these.
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
> 
> +1 on that. Even if, as I suspect, this is targeting some unspecified
> hypervisor that is not KVM, the first course of action should be for
> this to be implemented in the kernel's own hypervisor first so that
> anyone can review understand what is at play.
> 
> Thanks,
> 
>          M.

Thank you for your comments. The key value add of the feature is a third
party independent entity keeping a watch on crucial kernel assets, such 
that
in case the kernel itself is compromised, still, the protection can 
remain intact.
Can this be achieved if the implementation is done in KVM? I've limited 
knowledge
of KVM currently, can surely look into more details for a better 
understanding.

Agree that the mechanism for triaging what constitutes valid access 
needs a clear
approach. We will discuss your suggestions internally if we can use them 
to improve
the overall feature design and share updated patches. Thank you!
