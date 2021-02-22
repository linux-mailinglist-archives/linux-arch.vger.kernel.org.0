Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513CB32110F
	for <lists+linux-arch@lfdr.de>; Mon, 22 Feb 2021 07:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhBVGzc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Feb 2021 01:55:32 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:15373 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229852AbhBVGzb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Feb 2021 01:55:31 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613976911; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=ofgj+DChJuv4uQiMPMe3Ol2wZ5uQqx9bQQUd6t5Oc9A=;
 b=B5qJS1Gg+dTGor5/AhSNgKPO6yoN+3iiZcKSbACSmEIcOL51bEPwbz67bzSkkOLAP7xysoQv
 wrv7+nZx/uwYiRratMaXI9MvEtx4OW05fCK8LwlPpRyp8RrFaJjceKzUZrtoUQQv9X4NRg+C
 HuBtEvXGM+4HvgbsJ4+saVRusnI=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI5MDNlZiIsICJsaW51eC1hcmNoQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 603355317237f827dc2474b0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Feb 2021 06:54:41
 GMT
Sender: pnagar=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4F542C433C6; Mon, 22 Feb 2021 06:54:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pnagar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9710CC433CA;
        Mon, 22 Feb 2021 06:54:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 22 Feb 2021 12:24:38 +0530
From:   pnagar@codeaurora.org
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Will Deacon <will@kernel.org>, nmardana@codeaurora.org,
        johan@kernel.org, Joe Perches <joe@perches.com>,
        Jessica Yu <jeyu@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Eric Biggers <ebiggers@google.com>,
        Joel Galenson <jgalenson@google.com>
Subject: Re: [PATCH] RTIC: selinux: ARM64: Move selinux_state to a separate
 page
In-Reply-To: <CAKwvOdkTkTV6U7zv1WyndLwK_JCB5ptTz64UbqAEwRMV5o7dLw@mail.gmail.com>
References: <1613470672-3069-1-git-send-email-pnagar@codeaurora.org>
 <CAKwvOdkTkTV6U7zv1WyndLwK_JCB5ptTz64UbqAEwRMV5o7dLw@mail.gmail.com>
Message-ID: <92c05669eca0307421cd224e0a06e785@codeaurora.org>
X-Sender: pnagar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2021-02-16 23:39, Nick Desaulniers wrote:
> On Tue, Feb 16, 2021 at 2:19 AM Preeti Nagar <pnagar@codeaurora.org> 
> wrote:
>> 
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
>> 
>> Currently, the change moves selinux_state structure to a separate 
>> page.
>> The page is 2MB aligned not 4K to avoid TLB related performance impact 
>> as,
>> for some CPU core designs, the TLB does not cache 4K stage 2 (IPA to 
>> PA)
>> mappings if the IPA comes from a stage 1 mapping. In future, we plan 
>> to
>> move more security-related kernel assets to this page to enhance
>> protection.
>> 
>> Signed-off-by: Preeti Nagar <pnagar@codeaurora.org>
> 
> This addresses my feedback from the RFC regarding the section symbols.
> No comment on whether there is a better approach, or the 2MB vs page
> alignment, but perhaps other folks cc'ed can please take a look.
> 
> Acked-by: Nick Desaulniers <ndesaulniers@google.com>
> 
Thank you! I look forward to reviews and suggestions from the added 
folks.

>> ---
>> The RFC patch reviewed available at:
>> https://lore.kernel.org/linux-security-module/1610099389-28329-1-git-send-email-pnagar@codeaurora.org/
>> ---
>>  include/asm-generic/vmlinux.lds.h | 10 ++++++++++
>>  include/linux/init.h              |  6 ++++++
>>  security/Kconfig                  | 11 +++++++++++
>>  security/selinux/hooks.c          |  2 +-
>>  4 files changed, 28 insertions(+), 1 deletion(-)
>> 
>> diff --git a/include/asm-generic/vmlinux.lds.h 
>> b/include/asm-generic/vmlinux.lds.h
>> index b97c628..d1a5434 100644
>> --- a/include/asm-generic/vmlinux.lds.h
>> +++ b/include/asm-generic/vmlinux.lds.h
>> @@ -770,6 +770,15 @@
>>                 *(.scommon)                                            
>>  \
>>         }
>> 
>> +#ifdef CONFIG_SECURITY_RTIC
>> +#define RTIC_BSS                                                      
>>  \
>> +       . = ALIGN(SZ_2M);                                              
>>  \
>> +       KEEP(*(.bss.rtic))                                             
>>  \
>> +       . = ALIGN(SZ_2M);
>> +#else
>> +#define RTIC_BSS
>> +#endif
>> +
>>  /*
>>   * Allow archectures to redefine BSS_FIRST_SECTIONS to add extra
>>   * sections to the front of bss.
>> @@ -782,6 +791,7 @@
>>         . = ALIGN(bss_align);                                          
>>  \
>>         .bss : AT(ADDR(.bss) - LOAD_OFFSET) {                          
>>  \
>>                 BSS_FIRST_SECTIONS                                     
>>  \
>> +               RTIC_BSS                                               
>>  \
>>                 . = ALIGN(PAGE_SIZE);                                  
>>  \
>>                 *(.bss..page_aligned)                                  
>>  \
>>                 . = ALIGN(PAGE_SIZE);                                  
>>  \
>> diff --git a/include/linux/init.h b/include/linux/init.h
>> index e668832..e6d452a 100644
>> --- a/include/linux/init.h
>> +++ b/include/linux/init.h
>> @@ -300,6 +300,12 @@ void __init parse_early_options(char *cmdline);
>>  /* Data marked not to be saved by software suspend */
>>  #define __nosavedata __section(".data..nosave")
>> 
>> +#ifdef CONFIG_SECURITY_RTIC
>> +#define __rticdata  __section(".bss.rtic")
>> +#else
>> +#define __rticdata
>> +#endif
>> +
>>  #ifdef MODULE
>>  #define __exit_p(x) x
>>  #else
>> diff --git a/security/Kconfig b/security/Kconfig
>> index 7561f6f..1af913a 100644
>> --- a/security/Kconfig
>> +++ b/security/Kconfig
>> @@ -291,5 +291,16 @@ config LSM
>> 
>>  source "security/Kconfig.hardening"
>> 
>> +config SECURITY_RTIC
>> +       bool "RunTime Integrity Check feature"
>> +       depends on ARM64
>> +       help
>> +         RTIC(RunTime Integrity Check) feature is to protect Linux 
>> kernel
>> +         at runtime. This relocates some of the security sensitive 
>> kernel
>> +         structures to a separate RTIC specific page.
>> +
>> +         This is to enable monitoring and protection of these kernel 
>> assets
>> +         from a higher exception level(EL) against any unauthorized 
>> changes.
>> +
>>  endmenu
>> 
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 644b17e..59d7eee 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -104,7 +104,7 @@
>>  #include "audit.h"
>>  #include "avc_ss.h"
>> 
>> -struct selinux_state selinux_state;
>> +struct selinux_state selinux_state __rticdata;
>> 
>>  /* SECMARK reference count */
>>  static atomic_t selinux_secmark_refcount = ATOMIC_INIT(0);
>> --
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
>> member
>> of Code Aurora Forum, hosted by The Linux Foundation
>> 
