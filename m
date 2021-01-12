Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1F92F2B7C
	for <lists+linux-arch@lfdr.de>; Tue, 12 Jan 2021 10:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbhALJh6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Jan 2021 04:37:58 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:38782 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730499AbhALJh5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Jan 2021 04:37:57 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610444257; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=dcaBq1lXPNIqcnm6SkqqWpFwh40DCTmtIQVK4VfzQ4E=;
 b=QYpLPlwhzfEwUrgHAz9dasj1Y/SlCBxCe1inZlbO5syyRZWGycZD4D5cBUnnNfKHB8VUl6M2
 6coWHQ1yPhmwHBG1OiOvRL+5zImvxos4VHoBmXM3EAX357LcPZhytHlhifv74pLsHmu33VVP
 Z3ZCfM7GjV0WuE6Ojk+3GPu9L78=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI5MDNlZiIsICJsaW51eC1hcmNoQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5ffd6dbb415a6293c522aaa5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 12 Jan 2021 09:36:59
 GMT
Sender: pnagar=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 473B3C43464; Tue, 12 Jan 2021 09:36:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pnagar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 24930C43462;
        Tue, 12 Jan 2021 09:36:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 12 Jan 2021 15:06:57 +0530
From:   pnagar@codeaurora.org
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     arnd@arndb.de, jmorris@namei.org, serge@hallyn.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-arch@vger.kernel.org,
        psodagud@codeaurora.org, nmardana@codeaurora.org,
        dsule@codeaurora.org, Joe Perches <joe@perches.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] selinux: security: Move selinux_state to a
 separate page
In-Reply-To: <0f467390-e018-6051-0014-ab475ed76863@schaufler-ca.com>
References: <1610099389-28329-1-git-send-email-pnagar@codeaurora.org>
 <0f467390-e018-6051-0014-ab475ed76863@schaufler-ca.com>
Message-ID: <dab6357acbd63edd53099d106d111bf4@codeaurora.org>
X-Sender: pnagar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2021-01-08 22:41, Casey Schaufler wrote:
> On 1/8/2021 1:49 AM, Preeti Nagar wrote:
>> The changes introduce a new security feature, RunTime Integrity Check
>> (RTIC), designed to protect Linux Kernel at runtime. The motivation
>> behind these changes is:
>> 1. The system protection offered by SE for Android relies on the
>> assumption of kernel integrity. If the kernel itself is compromised 
>> (by
>> a perhaps as yet unknown future vulnerability), SE for Android 
>> security
>> mechanisms could potentially be disabled and rendered ineffective.
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
> 
> It would be helpful if you characterized the "various vulnerabilities"
> rather than simply asserting their existence. This would allow the 
> reviewer
> to determine if the proposed patch addresses the issue.
> 
There might not currently be vulnerabilities, but the system is meant 
more
specifically to harden valuable assets against future compromises. The 
key
value add is a third party independent entity keeping a watch on crucial
kernel assets.

>> 
>> The feature's idea is to move some sensitive kernel structures to a
>> separate page and monitor further any unauthorized changes to these,
>> from higher Exception Levels using stage 2 MMU. Moving these to a
>> different page will help avoid getting page faults from un-related 
>> data.
> 
> I've always been a little slow when it comes to understanding the
> details of advanced memory management facilities. That's part of
> why I work in access control. Could you expand this a bit, so that
> someone who doesn't already know how your stage 2 MMU works might
> be able to evaluate what you're doing here.
> 
Sure, will include more details. The mechanism we have been working on
removes the write permissions for HLOS in the stage 2 page tables for
the regions to be monitored, such that any modification attempts to 
these
will lead to faults being generated and handled by handlers. If the
protected assets are moved to a separate page, faults will be generated
corresponding to change attempts to these assets only. If not moved to a
separate page, write attempts to un-related data which is present on the
monitored pages will also be generated.

>> Using this mechanism, some sensitive variables of the kernel which are
>> initialized after init or are updated rarely can also be protected 
>> from
>> simple overwrites and attacks trying to modify these.
> 
> How would this interact with or complement __read_mostly?
> 
Currently, the mechanism we are working on developing is
independent of __read_mostly. This is something we can look more into
while working further on the mechanism.

>> 
>> Currently, the change moves selinux_state structure to a separate 
>> page. In
>> future we plan to move more security-related kernel assets to this 
>> page to
>> enhance protection.
> 
> What's special about selinux_state? What about the SELinux policy?
> How would I, as maintainer of the Smack security module, know if
> some Smack data should be treated the same way?
> 
We are investigating more of the SELinux related and other kernel assets
which can be included in the protection. The basis of selinux_state is
because disabling of SELinux is one of the common attack vectors in
Android. We understand any kernel assets, unauthorized changes to which
can give way to security or any other type of attack can be considered 
to
be a potential asset to be added to the protection.

>> 
>> We want to seek your suggestions and comments on the idea and the 
>> changes
>> in the patch.
>> 
>> Signed-off-by: Preeti Nagar <pnagar@codeaurora.org>
>> ---
>>  include/asm-generic/vmlinux.lds.h | 10 ++++++++++
>>  include/linux/init.h              |  4 ++++
>>  security/Kconfig                  | 10 ++++++++++
>>  security/selinux/hooks.c          |  4 ++++
>>  4 files changed, 28 insertions(+)
>> 
>> diff --git a/include/asm-generic/vmlinux.lds.h 
>> b/include/asm-generic/vmlinux.lds.h
>> index b2b3d81..158dbc2 100644
>> --- a/include/asm-generic/vmlinux.lds.h
>> +++ b/include/asm-generic/vmlinux.lds.h
>> @@ -770,6 +770,15 @@
>>  		*(.scommon)						\
>>  	}
>> 
>> +#ifdef CONFIG_SECURITY_RTIC
>> +#define RTIC_BSS							\
>> +	. = ALIGN(PAGE_SIZE);						\
>> +	KEEP(*(.bss.rtic))						\
>> +	. = ALIGN(PAGE_SIZE);
>> +#else
>> +#define RTIC_BSS
>> +#endif
>> +
>>  /*
>>   * Allow archectures to redefine BSS_FIRST_SECTIONS to add extra
>>   * sections to the front of bss.
>> @@ -782,6 +791,7 @@
>>  	. = ALIGN(bss_align);						\
>>  	.bss : AT(ADDR(.bss) - LOAD_OFFSET) {				\
>>  		BSS_FIRST_SECTIONS					\
>> +		RTIC_BSS						\
>>  		. = ALIGN(PAGE_SIZE);					\
>>  		*(.bss..page_aligned)					\
>>  		. = ALIGN(PAGE_SIZE);					\
>> diff --git a/include/linux/init.h b/include/linux/init.h
>> index 7b53cb3..617adcf 100644
>> --- a/include/linux/init.h
>> +++ b/include/linux/init.h
>> @@ -300,6 +300,10 @@ void __init parse_early_options(char *cmdline);
>>  /* Data marked not to be saved by software suspend */
>>  #define __nosavedata __section(".data..nosave")
>> 
>> +#ifdef CONFIG_SECURITY_RTIC
>> +#define __rticdata  __section(".bss.rtic")
>> +#endif
>> +
>>  #ifdef MODULE
>>  #define __exit_p(x) x
>>  #else
>> diff --git a/security/Kconfig b/security/Kconfig
>> index 7561f6f..66b61b9 100644
>> --- a/security/Kconfig
>> +++ b/security/Kconfig
>> @@ -291,5 +291,15 @@ config LSM
>> 
>>  source "security/Kconfig.hardening"
>> 
>> +config SECURITY_RTIC
>> +        bool "RunTime Integrity Check feature"
> 
> Shouldn't this depend on the architecture(s) supporting the
> feature?
> 
>> +        help
>> +	  RTIC(RunTime Integrity Check) feature is to protect Linux kernel
>> +	  at runtime. This relocates some of the security sensitive kernel
>> +	  structures to a separate page aligned special section.
>> +
>> +	  This is to enable monitoring and protection of these kernel assets
>> +	  from a higher exception level(EL) against any unauthorized 
>> changes.
> 
> "if you are unsure ..."
> 
We just thought keeping it generic might be a better idea, thus, moved 
the
changes to generic files from arch-specific files and thus, kept config 
also
independent of the arch. Can surely make this config arch dependent if 
that is
a better approach?

>> +
>>  endmenu
>> 
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 6b1826f..7add17c 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -104,7 +104,11 @@
>>  #include "audit.h"
>>  #include "avc_ss.h"
>> 
>> +#ifdef CONFIG_SECURITY_RTIC
>> +struct selinux_state selinux_state __rticdata;
>> +#else
>>  struct selinux_state selinux_state;
>> +#endif
> 
> Shouldn't the __rticdata tag be applied always, and its
> definition take care of the cases where it doesn't do anything?
> 
Will update this change in the next version of the patch. Thank you.

>> 
>>  /* SECMARK reference count */
>>  static atomic_t selinux_secmark_refcount = ATOMIC_INIT(0);
