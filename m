Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB4A98DC0
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2019 10:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfHVIcc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Aug 2019 04:32:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38437 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731123AbfHVIcb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Aug 2019 04:32:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id g17so4556456wrr.5
        for <linux-arch@vger.kernel.org>; Thu, 22 Aug 2019 01:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4b70yh01yux8LseDePSC/DiDISC+4IVFYV73p/rz2+o=;
        b=E8c1BVe7EBu6yhtFK7db335Fb1S6eHZXaT/G0r9s6o7yCfITCEzNdfIuD0wirYp7vb
         MjBwnsVUgiHDSiSTUkyjG1wIB9iwROJpD58qta21td0tKHQDUmwhpZdduxFB2zp6sebi
         jvUrA8A2D58nA2kFTgHoHam8Ya25z0Z5isgC5uLEVljRxOWdTmXYFCNu7V4jDwDYcxXO
         Tn/AhSkcu56p/oJC8gZNa9b0VNYEfc0WGmMiTJsmx6lTnUJ/u4ugOnZ+1Lqv9VyOuAkr
         NNngborlwcNM9CtXvqO9XoNQpVYvf7o4NuBeerxAGsY42aYL3eOxwqRmbKc320uBtg6u
         wCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4b70yh01yux8LseDePSC/DiDISC+4IVFYV73p/rz2+o=;
        b=eKI/jvjahDvEPZV8VzAgVcT+TA+rEPadFir/9fJhPMf2m1eXvYuWzW45jhS994cyLb
         d/JAEEP5kxW9UB2rnTeZ6ATfc68Hse3pREbV5nj9uG27G6Wa2ZgLiyDjIKMJX1eSR+p1
         dlgdjvicl2k5YI9l06RbqIQmaR5PWP0fWvuQgWvkK2EsUD1JDrWmPrLVWZNiZ/yn93U5
         r0CdFHf+cCeMOnIaspDHRfwliy7kxV0NcRoMrqCpwDArKuQ7GTxQ7BbAczrrX4usd6vZ
         a/9CKFc4G7tH9k46lBXCQozMRbhjwTLaDbfDRLawXY+zroXDLutzD6L2cbHJtt2VvRKi
         +G6A==
X-Gm-Message-State: APjAAAV78r2+4CZB6hWJwGgH9cjQSABcsyX6g/cpnd2G/GdMxjVA/kj8
        coTHHtikvPw4NVr9zRZx9yZ5Dg==
X-Google-Smtp-Source: APXvYqzhncQ2sLyFAXkyHMIdbyY5WIElP1PH9XUf0yABxgLd2l6QYEsJKT4aB0mYksaQ3+iKPSinPA==
X-Received: by 2002:a5d:4ec6:: with SMTP id s6mr7356600wrv.327.1566462748883;
        Thu, 22 Aug 2019 01:32:28 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
        by smtp.gmail.com with ESMTPSA id p4sm22917436wrs.6.2019.08.22.01.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 01:32:27 -0700 (PDT)
Date:   Thu, 22 Aug 2019 09:32:23 +0100
From:   Matthias Maennich <maennich@google.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        arnd@arndb.de, geert@linux-m68k.org, gregkh@linuxfoundation.org,
        hpa@zytor.com, jeyu@kernel.org, joel@joelfernandes.org,
        kstewart@linuxfoundation.org, linux-arch@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-modules@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-usb@vger.kernel.org, lucas.de.marchi@gmail.com,
        maco@android.com, maco@google.com, michal.lkml@markovi.net,
        mingo@redhat.com, oneukum@suse.com, pombredanne@nexb.com,
        sam@ravnborg.org, sspatil@google.com, stern@rowland.harvard.edu,
        tglx@linutronix.de, usb-storage@lists.one-eyed-alien.net,
        x86@kernel.org, yamada.masahiro@socionext.com
Subject: Re: [PATCH v3 10/11] RFC: usb-storage: export symbols in USB_STORAGE
 namespace
Message-ID: <20190822083223.GA15709@google.com>
References: <20190813121733.52480-1-maennich@google.com>
 <20190821114955.12788-1-maennich@google.com>
 <20190821114955.12788-11-maennich@google.com>
 <20190821231329.GA369@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190821231329.GA369@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 21, 2019 at 04:13:29PM -0700, Christoph Hellwig wrote:
>On Wed, Aug 21, 2019 at 12:49:25PM +0100, Matthias Maennich wrote:
>> Modules using these symbols are required to explicitly import the
>> namespace. This patch was generated with the following steps and serves
>> as a reference to use the symbol namespace feature:
>>
>>  1) Define DEFAULT_SYMBOL_NAMESPACE in the corresponding Makefile
>>  2) make  (see warnings during modpost about missing imports)
>>  3) make nsdeps
>>
>> Instead of a DEFAULT_SYMBOL_NAMESPACE definition, the EXPORT_SYMBOL_NS
>> variants can be used to explicitly specify the namespace. The advantage
>> of the method used here is that newly added symbols are automatically
>> exported and existing ones are exported without touching their
>> respective EXPORT_SYMBOL macro expansion.
>
>So what is USB_STORAGE here?  It isn't a C string, so where does it
>come from?  To me using a C string would seem like the nicer interface
>vs a random cpp symbol that gets injected somewhere.

To be honest, I would also prefer an interface that uses C strings or
literals for the new EXPORT_SYMBOLS* macros:

  EXPORT_SYMBOL_NS(mysym, "USB_STORAGE");

  or

  const char USB_STORAGE_NS[] = "USB_STORAGE";
  EXPORT_SYMBOL_NS(mysym, USB_STORAGE_NS);

The DEFAULT_SYMBOL_NAMESPACE define within Makefiles would get a bit
more verbose in that case to express the literal:
  ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE="\"USB_STORAGE\""


The main reason against that, is, that in the expansion of
EXPORT_SYMBOL_NS, we define the ksymtab entry, which name is
constructed partly by the name of the namespace:

   static const struct kernel_symbol __ksymtab_##sym##__##ns  ...
                                                        ^^^^

For that we depend on a cpp symbol to construct the name. I am not sure
there is a reasonable way of getting rid of that without ending up
constructing the ksymtab entries completely in asm as it is already done
in case of PREL32_RELOCATIONS. But I am happy to be corrected.

For reference that is done in patch 03/11 of this series:
https://lore.kernel.org/lkml/20190821114955.12788-4-maennich@google.com/

Cheers,
Matthias
