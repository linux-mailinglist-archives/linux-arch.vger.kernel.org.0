Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4203BA0050
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2019 12:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfH1K4e (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Aug 2019 06:56:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41003 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfH1K4e (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Aug 2019 06:56:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id j16so2005853wrr.8
        for <linux-arch@vger.kernel.org>; Wed, 28 Aug 2019 03:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vx9t5xjLzwxSs68UQHUay9ecnGA4GXfJUCmBL33YCMk=;
        b=NVdwLJqMFK27Egi+W5DT/3XO+B227WKx3M16ICzoXvtv3NVx+kYKIWtAq4ZidBcYR/
         6IGwVIoAcsDgTwvd+pwztc4kqW7mf2sSDts/mC7aobOdzcsHuc/F1dpU/BpqoiE9ML/s
         cDjmOLbsoCc6teLG/5wl/NGS2xAgrdjgeDYEI91IhxSHXf76R4GeGYbxSFH+75iaJUfe
         wT8+75/RkSk5caZV3qv54/qXQy42Kzg3eZmIM2FCd4NoNwrSMF71P581+GSac3L9QeRC
         S3Wx1vvGVwqa0gtVdM4obwVJsgIHz4ohf44ieueSHJ/wOuQxb45CsaAbBU1sGHgIo0nm
         DTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vx9t5xjLzwxSs68UQHUay9ecnGA4GXfJUCmBL33YCMk=;
        b=h8s0/87DQ73DXg+yX9yCuwBqgwsryC6+h/T5R/IFIQ0J7yds4H1du2FrThFOr3Np3b
         uHLZ/G5UaZ/4OBtZBfPuU+jlzRe1E22C6rLL+EQlrV29qd8IW0rQR76PsJnipBXRHtpu
         G7WYb3Mql9pWpQqUNHHoE3E+WqmtJIL4M+7uyNtAVRA/yBwBs/HzjAyraikkrwQs4axP
         vQrdCqFcTa87CZgyUimrBNRK6nxJgHddHYiRi57qlCmkHhF2PNfDlS/OnAuD9CNyZp7R
         cf1/+dbesFXp0WKhbpx1cTAjas/RFhY0GNvxm521mfvRcZpTz1WJZoc4gmK3J2dl2myv
         DQ0g==
X-Gm-Message-State: APjAAAVHGcQuMb8QPW8m7NkSfLscpYxCusfMU9QDINVvM1co/CRu1Vwr
        NuZdhJ5bLolHJrYvXt8mgkjc7w==
X-Google-Smtp-Source: APXvYqzmp0a1H7Elm+SaoHNY31yTb5NC/BkvI3kruZqJ9jlO42a8aciCDXtLmxYxYGNQyoKWXYPq/A==
X-Received: by 2002:adf:ce81:: with SMTP id r1mr3959629wrn.114.1566989791786;
        Wed, 28 Aug 2019 03:56:31 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
        by smtp.gmail.com with ESMTPSA id f6sm4573707wrh.30.2019.08.28.03.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 03:56:31 -0700 (PDT)
Date:   Wed, 28 Aug 2019 11:56:27 +0100
From:   Matthias Maennich <maennich@google.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        arnd@arndb.de, geert@linux-m68k.org, gregkh@linuxfoundation.org,
        hpa@zytor.com, joel@joelfernandes.org,
        kstewart@linuxfoundation.org, linux-arch@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-modules@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-usb@vger.kernel.org, lucas.de.marchi@gmail.com,
        maco@android.com, maco@google.com, michal.lkml@markovi.net,
        mingo@redhat.com, oneukum@suse.com, pombredanne@nexb.com,
        sam@ravnborg.org, sspatil@google.com, stern@rowland.harvard.edu,
        tglx@linutronix.de, usb-storage@lists.one-eyed-alien.net,
        x86@kernel.org, yamada.masahiro@socionext.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ingo Molnar <mingo@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v3 06/11] export: allow definition default namespaces in
 Makefiles or sources
Message-ID: <20190828105627.GA41539@google.com>
References: <20190813121733.52480-1-maennich@google.com>
 <20190821114955.12788-1-maennich@google.com>
 <20190821114955.12788-7-maennich@google.com>
 <20190828104951.GC25048@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190828104951.GC25048@linux-8ccs>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 28, 2019 at 12:49:51PM +0200, Jessica Yu wrote:
>+++ Matthias Maennich [21/08/19 12:49 +0100]:
>>To avoid excessive usage of EXPORT_SYMBOL_NS(sym, MY_NAMESPACE), where
>>MY_NAMESPACE will always be the namespace we are exporting to, allow
>>exporting all definitions of EXPORT_SYMBOL() and friends by defining
>>DEFAULT_SYMBOL_NAMESPACE.
>>
>>For example, to export all symbols defined in usb-common into the
>>namespace USB_COMMON, add a line like this to drivers/usb/common/Makefile:
>>
>> ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=USB_COMMON
>>
>>That is equivalent to changing all EXPORT_SYMBOL(sym) definitions to
>>EXPORT_SYMBOL_NS(sym, USB_COMMON). Subsequently all symbol namespaces
>>functionality will apply.
>>
>>Another way of making use of this feature is to define the namespace
>>within source or header files similar to how TRACE_SYSTEM defines are
>>used:
>> #undef DEFAULT_SYMBOL_NAMESPACE
>> #define DEFAULT_SYMBOL_NAMESPACE USB_COMMON
>>
>>Please note that, as opposed to TRACE_SYSTEM, DEFAULT_SYMBOL_NAMESPACE
>>has to be defined before including include/linux/export.h.
>>
>>If DEFAULT_SYMBOL_NAMESPACE is defined, a symbol can still be exported
>>to another namespace by using EXPORT_SYMBOL_NS() and friends with
>>explicitly specifying the namespace.
>
>This changelog provides a good summary of how to use
>DEFAULT_SYMBOL_NAMESPACE, I wonder if we should explicitly document
>its proper usage somewhere? (along with EXPORT_SYMBOL_NS*)
>The EXPORT_SYMBOL API is briefly documented in
>Documentation/kernel-hacking/hacking.rst - it might be slightly dated,
>but perhaps it'd fit there best?

I will add documentation along with the commits. Not only for the
macros, but in general to describe the feature.

>>Suggested-by: Arnd Bergmann <arnd@arndb.de>
>>Reviewed-by: Martijn Coenen <maco@android.com>
>>Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>Signed-off-by: Matthias Maennich <maennich@google.com>
>>---
>>include/linux/export.h | 6 ++++++
>>1 file changed, 6 insertions(+)
>>
>>diff --git a/include/linux/export.h b/include/linux/export.h
>>index 8e12e05444d1..1fb243abdbc4 100644
>>--- a/include/linux/export.h
>>+++ b/include/linux/export.h
>>@@ -166,6 +166,12 @@ struct kernel_symbol {
>>#define __EXPORT_SYMBOL ___EXPORT_SYMBOL
>>#endif
>>
>>+#ifdef DEFAULT_SYMBOL_NAMESPACE
>>+#undef __EXPORT_SYMBOL
>>+#define __EXPORT_SYMBOL(sym, sec)				\
>>+	__EXPORT_SYMBOL_NS(sym, sec, DEFAULT_SYMBOL_NAMESPACE)
>>+#endif
>>+
>>#define EXPORT_SYMBOL(sym) __EXPORT_SYMBOL(sym, "")
>>#define EXPORT_SYMBOL_GPL(sym) __EXPORT_SYMBOL(sym, "_gpl")
>>#define EXPORT_SYMBOL_GPL_FUTURE(sym) __EXPORT_SYMBOL(sym, "_gpl_future")
>>-- 
>>2.23.0.rc1.153.gdeed80330f-goog
>>
