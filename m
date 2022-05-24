Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E3353333A
	for <lists+linux-arch@lfdr.de>; Wed, 25 May 2022 00:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242019AbiEXWGv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 May 2022 18:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236103AbiEXWGu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 May 2022 18:06:50 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838662F020;
        Tue, 24 May 2022 15:06:49 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id v9so18386760oie.5;
        Tue, 24 May 2022 15:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nazAJnmKC29W9OE3p4jtrAjcYB6KyAUjKMWBeLzTPEM=;
        b=pcnkDXAe5YvTRgJxeRg3matW3Bv2wtdSXK2Y9Hhj3sk6qgF61Ruuf0leQFCEirgQ7C
         TtUxSytvQlTV0hrf7SgFsfLm4pPUSiAEwfEAiDfG+gThPQcLXdGJSK6JHNeep3tRNJ7+
         YDxIKarQEOKdoCzcTVFB7JZVwvNYK5/lER5aExjEL2QXKzNws3LspaPVFgYSsz+Df5OO
         AwYS+zoL7QF5PiLOdJpQg4nnSt/V9RUgdEJ5wZMHdPTNEuVr8PebFOltKY2dkCe/XFbt
         Uhc/lImMGV4sNqpIxtqzD3SJUdxInK/NOcl8uFrZ2Zr5Q6VjdDZrqJ6pPfQznwY5JKmN
         CRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=nazAJnmKC29W9OE3p4jtrAjcYB6KyAUjKMWBeLzTPEM=;
        b=elKfla4XlC3NjI+Guyj3mIUzkn2OnxrZnBkvwhq5geiw3NkXXwUz73pT+i2Lt/G8R4
         zFMD2O6PZBGLAF8slNQEtei90/CzEeImKVQyZhnNRWdGpfdtuVDlpd2mcvMV1gzl37Oq
         4OkNg3ufqLafURFy14QLXSCJnw4/moWPucDYe3OLaaux/luPmQyHeIEFx8XEXYC4wl9L
         cJy6DExOZUhi5m2Eti/T28oPoKyT8Y0KennW9UOlZCBqJWVVsa/kM/HUUZp+8a9dk2Y+
         yBYqaAGSQztIxggfb8BYo9qYV8f/BluAJa7X8vs8gdgdEoolMpWCGB29fLOCej9xiRrW
         r76w==
X-Gm-Message-State: AOAM533nZn7+H8Q+V/CrtL1W1O5r4ZNI7K4n9qJ9ZzW9f4VUMdeCxhiE
        pXpdVsTtEUew7xEZ29XvQYY=
X-Google-Smtp-Source: ABdhPJylOJvDhga94lACYzo4DYHszPBVfc6hKDFXDCn+ItVVcIHVwPQKrHsoO+UpMTYhmFLK0bMmjw==
X-Received: by 2002:aca:5a0a:0:b0:32b:a51:6cd8 with SMTP id o10-20020aca5a0a000000b0032b0a516cd8mr3580050oib.112.1653430008860;
        Tue, 24 May 2022 15:06:48 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q7-20020aca4307000000b00325cda1ffa2sm5734695oia.33.2022.05.24.15.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 15:06:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 24 May 2022 15:06:46 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V9 20/20] riscv: compat: Add COMPAT Kbuild skeletal
 support
Message-ID: <20220524220646.GA3990738@roeck-us.net>
References: <20220322144003.2357128-1-guoren@kernel.org>
 <20220322144003.2357128-21-guoren@kernel.org>
 <20220523054550.GA1511899@roeck-us.net>
 <CAJF2gTQ5RS8wGfSDPoB4JLtPBoM=ainuz_EJ9Tweq0mqPM=ALA@mail.gmail.com>
 <CAJF2gTSa=roJOiKFiL8nSQ12E-emz-xrXs=RNAc4zSFaPuRAzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTSa=roJOiKFiL8nSQ12E-emz-xrXs=RNAc4zSFaPuRAzw@mail.gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 25, 2022 at 01:46:38AM +0800, Guo Ren wrote:
[ ... ]

> > The problem is come from "__dls3's vdso decode part in musl's
> > ldso/dynlink.c". The ehdr->e_phnum & ehdr->e_phentsize are wrong.
> >
> > I think the root cause is from musl's implementation with the wrong
> > elf parser. I would fix that soon.
> Not elf parser, it's "aux vector just past environ[]". I think I could
> solve this, but anyone who could help dig in is welcome.
> 

I am not sure I understand what you are saying here. Point is that my
root file system, generated with musl a year or so ago, crashes with
your patch set applied. That is a regression, even if there is a bug
in musl.

Guenter
