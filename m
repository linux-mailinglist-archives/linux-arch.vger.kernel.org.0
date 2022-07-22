Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BE357E8FB
	for <lists+linux-arch@lfdr.de>; Fri, 22 Jul 2022 23:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236178AbiGVVnf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Jul 2022 17:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiGVVnf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Jul 2022 17:43:35 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E662B5CAF;
        Fri, 22 Jul 2022 14:43:34 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id b10so5393961pjq.5;
        Fri, 22 Jul 2022 14:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i4Qp1mKbIG2ruYUdux/tc/3csBK1hzMenyp+t9FkaYk=;
        b=FRbsnnig1i03refpFl63/oYlraRh54F+mJVHhcNi2f4eeFNzYIp7qg4GQM9aN6VAp2
         y6oOij7gj/FKdqLi7xJGownmX/nVVSlkLkcRP75s/8ETfXBivanzKdoecGl451+B0G9M
         5Nm04yoIVcl2UXc68JS+DR0lVc8Z63qI7A40Lz++GlqZboTjktogd+sTIiNnfSuSNn9q
         54OdXFAby1g0IEQgkOUzixoj7dWll3RbROqD2LO1TrdZnsfhqyGqOe0CQY2nPgO3u0ms
         tPCQMgLaB24XcjaXETs320r93j1KKENMbYJFui4dpYkNrKd9EbgKu9aoYklJNW8c4r8F
         NDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i4Qp1mKbIG2ruYUdux/tc/3csBK1hzMenyp+t9FkaYk=;
        b=AJGjHaWp/Zrkwbt5jLqfLnQ09GkleSWyLcKbL2YGTM78yJwatLG9DVgfhXgefCDGrS
         FIql5oqaUzPwkCwmAp8TeitUHAjCk/y28lHRy7gC3CG0xSlsE/QW/6eDQ+d+OTkQ10E1
         NDcpRn1gU9+KXG9WpG09iX0b2oXLWVu+bd4AdvICbS7vBbGTS0ZCWqyF47XysvEjkQpE
         pJmDLdyAI+qPOKDMMDefuhhTGru7dYGZQmCm9IjkJh3BR3Cbvzs542/3icF/hSLn1ZE0
         cL7PC+c2bT+zVQKl3le54OBXhfj0vmOHHDQq+e5niGyX3K8tdnRSLZOomjvMCEnr4USM
         rynw==
X-Gm-Message-State: AJIora9+OMrgrnbm3XvWrd7VC89Ln/9Lt4kcrseCZg9E26TmR0xhQ293
        0pxxEDMpwuysT39i4tRuY/E=
X-Google-Smtp-Source: AGRyM1tDESdKAY40zEtiRQTmyQgc9zR+ckOecpVbQSNki8M4gmNYammHVylV0yXZ2taDdNJJIYKkvw==
X-Received: by 2002:a17:90a:bb12:b0:1f2:59a7:657a with SMTP id u18-20020a17090abb1200b001f259a7657amr1726131pjr.151.1658526213902;
        Fri, 22 Jul 2022 14:43:33 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id g8-20020aa79f08000000b0052b6277df9esm4344616pfr.43.2022.07.22.14.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 14:43:33 -0700 (PDT)
Date:   Sat, 23 Jul 2022 06:43:31 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v5 4/4] asm-generic: Add new pci.h and use it
Message-ID: <YtsaA2Zjqa/XZZou@antec>
References: <20220721134924.596152-5-shorne@gmail.com>
 <20220721173733.GA1731649@bhelgaas>
 <YtnMEwh3U3Ng9q4a@antec>
 <CAK8P3a3T0GvYyRgw=ojD_wts_pfdzfqXS8iNfUYuByBvLF9SGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3T0GvYyRgw=ojD_wts_pfdzfqXS8iNfUYuByBvLF9SGQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 22, 2022 at 09:53:07AM +0200, Arnd Bergmann wrote:
> On Thu, Jul 21, 2022 at 11:58 PM Stafford Horne <shorne@gmail.com> wrote:
> > On Thu, Jul 21, 2022 at 12:37:33PM -0500, Bjorn Helgaas wrote:
> 
> >
> > Thanks, you are right, I think some of the earlier functions may have needed it,
> > which is why I had it earlier.  But now that we have removed those we should be
> > able to remove this.
> >
> > That said, I think some of the architecture includes could also be removed.  On
> > OpenRISC we are able to get away with only having the global asm-generic/pci.h
> > so we don't need a wrapper pci.h header at all.
> >
> > However, I don't have everything setup to build all of those architectures so I
> > was being a bit conservative to remove headers.  I'll see what I can do in the
> > next version.
> 
> No need to worry about linux/types.h, this is pretty much included everywhere
> already and neither the risk of extraneous includes or missing ones is
> something to worry about. I'd just remove it if you do another respin, or
> we can leave it in if Bjorn wants to just apply the v5 version.

I will respin a v6 as we didn't get a reply on this.  Bjorn are you planning to
apply the series before the upcoming merge window?

Originally I was thinking to merge these with my OpenRISC PCI support patches as
OpenRISC depends on this.  However, the series is getting a bit more involved
for OpenRISC only.

Once you get it merged I will like to rebase my OpenRISC PCI support patches on
you branch.  Hopefully, we can make it by the merge window.

Also, Palmer has a conflict with the series and his RISC-V for-next branch.
He would like to have a tag or branch to be able to merge into is branch to
resolve the conflict.

-Stafford
