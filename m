Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DDD2F999A
	for <lists+linux-arch@lfdr.de>; Mon, 18 Jan 2021 06:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731849AbhARF6I (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 Jan 2021 00:58:08 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:56164 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731840AbhARF50 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Jan 2021 00:57:26 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610949426; h=Message-ID: Subject: Cc: To: From: Date:
 Content-Transfer-Encoding: Content-Type: MIME-Version: Sender;
 bh=Y5tb+FamCD4fE7la8PAvRJnTl96e73Nm7Kz1X9XqF1Y=; b=aZVWVjsxz9rcmKnnRSTkGAFZCdGDmcZqBIb8QtDJMUSi/ahFD7yN308sEnGmjTDkG4ONiPvh
 hXPE7YMbpX7IUsP9LIwMA7lA6CYshK67Y8GlJMFcVKkqcfSUk2KDjEMaFsqlNi5uBozOP9/j
 s4ejZZQVpezGFcG/nGCbsAiUrlo=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI5MDNlZiIsICJsaW51eC1hcmNoQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 6005230c02b2f1cb1a7d9ffa (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 18 Jan 2021 05:56:27
 GMT
Sender: pnagar=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1154EC43467; Mon, 18 Jan 2021 05:56:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pnagar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0C868C433CA;
        Mon, 18 Jan 2021 05:56:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 18 Jan 2021 11:26:24 +0530
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
Message-ID: <7f33036270f781568858bbc17a496b48@codeaurora.org>
X-Sender: pnagar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2021-01-12 22:36, Casey Schaufler wrote:
> On 1/12/2021 1:36 AM, pnagar@codeaurora.org wrote:
>> On 2021-01-08 22:41, Casey Schaufler wrote:
>>> On 1/8/2021 1:49 AM, Preeti Nagar wrote:
>>>> The changes introduce a new security feature, RunTime Integrity 
>>>> Check
>>>> (RTIC), designed to protect Linux Kernel at runtime. The motivation
>>>> behind these changes is:
>>>> 1. The system protection offered by SE for Android relies on the
>>>> assumption of kernel integrity. If the kernel itself is compromised 
>>>> (by
>>>> a perhaps as yet unknown future vulnerability), SE for Android 
>>>> security
>>>> mechanisms could potentially be disabled and rendered ineffective.
>>>> 2. Qualcomm Snapdragon devices use Secure Boot, which adds 
>>>> cryptographic
>>>> checks to each stage of the boot-up process, to assert the 
>>>> authenticity
>>>> of all secure software images that the device executes.  However, 
>>>> due to
>>>> various vulnerabilities in SW modules, the integrity of the system 
>>>> can be
>>>> compromised at any time after device boot-up, leading to 
>>>> un-authorized
>>>> SW executing.
>>> 
>>> It would be helpful if you characterized the "various 
>>> vulnerabilities"
>>> rather than simply asserting their existence. This would allow the 
>>> reviewer
>>> to determine if the proposed patch addresses the issue.
>>> 
>> There might not currently be vulnerabilities, but the system is meant 
>> more
>> specifically to harden valuable assets against future compromises. The 
>> key
>> value add is a third party independent entity keeping a watch on 
>> crucial
>> kernel assets.
> 
> Could you characterize the potential vulnerabilities, then?
> Seriously, there's a gazillion ways data integrity can be
> compromised. Which of those are addressed?
> 
1. Memory Corruption vulnerabilities (example buffer overflows) which 
can be
exploited to modify the critical kernel assets as a part of a directed 
attack
or inadvertently are the major type of vulnerabilities which this 
mechanism
directly addresses.
2. This can be useful in preventing privilege escalation attacks 
(modifying
some critical kernel structures) which can be caused by exploits 
targetting
various other types of vulnerabilities such as improper input validation 
and
integer overflows.

>> 
>>>> Using this mechanism, some sensitive variables of the kernel which 
>>>> are
>>>> initialized after init or are updated rarely can also be protected 
>>>> from
>>>> simple overwrites and attacks trying to modify these.
>>> 
>>> How would this interact with or complement __read_mostly?
>>> 
>> Currently, the mechanism we are working on developing is
>> independent of __read_mostly. This is something we can look more into
>> while working further on the mechanism.
> 
> Please either integrate the two or explain how they differ.
> It appears that you haven't considered how you might exploit
> or expand the existing mechanism.
> 
On looking up more about __read_mostly and also as David Howells shared, 
I
understand there two are different.
__read_mostly is seemed to be primarily designed for cache-related 
performance
improvement [1]. In RTIC design, the idea is of protection and 
monitoring aspect.
If there are some security-critical kernel assets which are expected to 
be
updated sometimes or rarely, then, we can monitor the writes to these as 
well
and check for any unauthorized attempts.
1. https://lkml.org/lkml/2007/12/13/487

>> 
>>>> 
>>>> Currently, the change moves selinux_state structure to a separate 
>>>> page. In
>>>> future we plan to move more security-related kernel assets to this 
>>>> page to
>>>> enhance protection.
>>> 
>>> What's special about selinux_state? What about the SELinux policy?
>>> How would I, as maintainer of the Smack security module, know if
>>> some Smack data should be treated the same way?
>>> 
>> We are investigating more of the SELinux related and other kernel 
>> assets
>> which can be included in the protection. The basis of selinux_state is
>> because disabling of SELinux is one of the common attack vectors in
>> Android. We understand any kernel assets, unauthorized changes to 
>> which
>> can give way to security or any other type of attack can be considered 
>> to
>> be a potential asset to be added to the protection.
> 
> Yeah, I get that. It looks like this could be a useful mechanism
> beyond SELinux. No point in hoarding it.
> 
Thank you! Will try and update the commit header line if possible to 
convey this
information.

>> 
>>>> 
>>>> We want to seek your suggestions and comments on the idea and the 
>>>> changes
>>>> in the patch.
>>>> 
>>>> Signed-off-by: Preeti Nagar <pnagar@codeaurora.org>
>>>> ---
>>>>  include/asm-generic/vmlinux.lds.h | 10 ++++++++++
>>>>  include/linux/init.h              |  4 ++++
>>>>  security/Kconfig                  | 10 ++++++++++
>>>>  security/selinux/hooks.c          |  4 ++++
>>>>  4 files changed, 28 insertions(+)
>>>> 
>>>> diff --git a/include/asm-generic/vmlinux.lds.h 
>>>> b/include/asm-generic/vmlinux.lds.h
>>>> index b2b3d81..158dbc2 100644
>>>> --- a/include/asm-generic/vmlinux.lds.h
>>>> +++ b/include/asm-generic/vmlinux.lds.h
>>>> @@ -770,6 +770,15 @@
>>>>          *(.scommon)                        \
>>>>      }
>>>> 
>>>> +#ifdef CONFIG_SECURITY_RTIC
>>>> +#define RTIC_BSS                            \
>>>> +    . = ALIGN(PAGE_SIZE);                        \
>>>> +    KEEP(*(.bss.rtic))                        \
>>>> +    . = ALIGN(PAGE_SIZE);
>>>> +#else
>>>> +#define RTIC_BSS
>>>> +#endif
>>>> +
>>>>  /*
>>>>   * Allow archectures to redefine BSS_FIRST_SECTIONS to add extra
>>>>   * sections to the front of bss.
>>>> @@ -782,6 +791,7 @@
>>>>      . = ALIGN(bss_align);                        \
>>>>      .bss : AT(ADDR(.bss) - LOAD_OFFSET) {                \
>>>>          BSS_FIRST_SECTIONS                    \
>>>> +        RTIC_BSS                        \
>>>>          . = ALIGN(PAGE_SIZE);                    \
>>>>          *(.bss..page_aligned)                    \
>>>>          . = ALIGN(PAGE_SIZE);                    \
>>>> diff --git a/include/linux/init.h b/include/linux/init.h
>>>> index 7b53cb3..617adcf 100644
>>>> --- a/include/linux/init.h
>>>> +++ b/include/linux/init.h
>>>> @@ -300,6 +300,10 @@ void __init parse_early_options(char *cmdline);
>>>>  /* Data marked not to be saved by software suspend */
>>>>  #define __nosavedata __section(".data..nosave")
>>>> 
>>>> +#ifdef CONFIG_SECURITY_RTIC
>>>> +#define __rticdata  __section(".bss.rtic")
>>>> +#endif
>>>> +
>>>>  #ifdef MODULE
>>>>  #define __exit_p(x) x
>>>>  #else
>>>> diff --git a/security/Kconfig b/security/Kconfig
>>>> index 7561f6f..66b61b9 100644
>>>> --- a/security/Kconfig
>>>> +++ b/security/Kconfig
>>>> @@ -291,5 +291,15 @@ config LSM
>>>> 
>>>>  source "security/Kconfig.hardening"
>>>> 
>>>> +config SECURITY_RTIC
>>>> +        bool "RunTime Integrity Check feature"
>>> 
>>> Shouldn't this depend on the architecture(s) supporting the
>>> feature?
>>> 
>>>> +        help
>>>> +      RTIC(RunTime Integrity Check) feature is to protect Linux 
>>>> kernel
>>>> +      at runtime. This relocates some of the security sensitive 
>>>> kernel
>>>> +      structures to a separate page aligned special section.
>>>> +
>>>> +      This is to enable monitoring and protection of these kernel 
>>>> assets
>>>> +      from a higher exception level(EL) against any unauthorized 
>>>> changes.
>>> 
>>> "if you are unsure ..."
>>> 
>> We just thought keeping it generic might be a better idea, thus, moved 
>> the
>> changes to generic files from arch-specific files and thus, kept 
>> config also
>> independent of the arch. Can surely make this config arch dependent if 
>> that is
>> a better approach?
> 
> It's kind of silly to enable this if the hardware doesn't
> support it, isn't it?
> 
Yes, that makes sense. Will update depends on to the ARM64 arch in the 
next
version. Thank you.
