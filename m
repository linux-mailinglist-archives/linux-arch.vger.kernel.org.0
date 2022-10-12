Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E9F5FC6F9
	for <lists+linux-arch@lfdr.de>; Wed, 12 Oct 2022 16:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiJLOF1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Oct 2022 10:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiJLOFZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Oct 2022 10:05:25 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C429D3911D;
        Wed, 12 Oct 2022 07:05:23 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l1-20020a17090a72c100b0020a6949a66aso2162328pjk.1;
        Wed, 12 Oct 2022 07:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LBlu7tPT0Tx5MrjvdiscmABwb2kCDpiFMguHWsE1qRI=;
        b=TriEn0TBit/DhtfVmixexLUZ4cUN9xq7qt7CmMgifx0UYigJtkT8QUVnkhv34TEPqV
         WvL7xPmd1PvCBxp4IEbGmJOfyAH3pw9dFJcFEaRY2ghKvoMiSon30uxminzvjSS6s1gh
         7hRpGaqX7MCzROsRMGzLYNd4HM4lbnEdvkNPjgwYFRx8UzsZ28boB3Y09SiyEIJxxIQ3
         ZRTs/GO0NM23bjGMkHwdX8dklDjz+orMbj+wRThAa0YxQyFPq02854mvleJ2oxRgHwRO
         +8DR32cLkSVyBJuRrD27zQxAzzakPoSzrXiUuyMNBsSTwFKUhozZ1fbiJ0F9XNy8mSB/
         Mn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LBlu7tPT0Tx5MrjvdiscmABwb2kCDpiFMguHWsE1qRI=;
        b=o2VxKsqlWBb7c8e1T2V7NNEwguBUUZI+wEkVWCG83+R1gdlnQTH+rXaZcSqjTDsOTM
         S/FZMFlxZ0aEi0G5cWAl/RX/l/967+q1u7WT8RZIpZK9PkRVNMOu7EZlw+50qHFb8fCl
         dM4x39f+94US9Ajhsgm/WFIzw6aKWpKjVmyIuWlACaCcYansK/jSAko8UniTTCgkEFTt
         uPrT54uzAyD32SeGtvio8g1GrZSEwSlOeHOSLFS0xUXK8r+Nz2Rp82HD+xvpaP7Aejk0
         VmBj68kGvQaFOeJRYN3Ch89x7faL/5h0wOBtZc3dFh49t7EtxnfR9c4mhp+fkkwf4LvL
         WxZg==
X-Gm-Message-State: ACrzQf3d5ZjOPaLiZdsCpRyIIwi8dKB0DxSfWqRUTf/pzxnw/+MGek2R
        uPCMIltaxo7gMfzixZ7grGA=
X-Google-Smtp-Source: AMsMyM533bBiEubHIjupTgGRt7/XMfF4p3p2/+tATp4bKUGSSf5uOxbPfntEFeuulxdGlsyniGXYUA==
X-Received: by 2002:a17:90b:4b42:b0:20d:954e:28d with SMTP id mi2-20020a17090b4b4200b0020d954e028dmr2205621pjb.93.1665583523209;
        Wed, 12 Oct 2022 07:05:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f9-20020a636a09000000b004277f43b736sm9607783pgc.92.2022.10.12.07.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 07:05:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 12 Oct 2022 07:05:19 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        regressions@lists.linux.dev
Subject: Re: [PATCH] alpha: Use generic <asm-generic/io.h>
Message-ID: <20221012140519.GA2405113@roeck-us.net>
References: <20220818092059.103884-1-linus.walleij@linaro.org>
 <20221002224521.GA968453@roeck-us.net>
 <fd905ca5-fe0d-4cfb-a0d0-aea8af539cc7@app.fastmail.com>
 <57200020-c460-74ec-c786-9a2c16f4870e@roeck-us.net>
 <2e110666-7519-4693-8a89-240cbb118c7e@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e110666-7519-4693-8a89-240cbb118c7e@app.fastmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 04, 2022 at 10:28:24PM +0200, Arnd Bergmann wrote:
> On Tue, Oct 4, 2022, at 9:42 PM, Guenter Roeck wrote:
> > On 10/3/22 06:03, Arnd Bergmann wrote:
> >> On Mon, Oct 3, 2022, at 12:45 AM, Guenter Roeck wrote:
> >
> > Looks like something was missed. When building alpha:allnoconfig
> > in next-20221004:
> >
> > Building alpha:allnoconfig ... failed
> > --------------
> > Error log:
> > <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
> > arch/alpha/kernel/core_marvel.c:807:1: error: conflicting types for 
> > 'marvel_ioread8'; have 'unsigned int(const void *)'
> >    807 | marvel_ioread8(const void __iomem *xaddr)
> >        | ^~~~~~~~~~~~~~
> > In file included from arch/alpha/kernel/core_marvel.c:10:
> > arch/alpha/include/asm/core_marvel.h:335:11: note: previous declaration 
> > of 'marvel_ioread8' with type 'u8(const void *)' {aka 'unsigned 
> > char(const void *)'}
> >    335 | extern u8 marvel_ioread8(const void __iomem *);
> >        |           ^~~~~~~~~~~~~~
> 
> Right, I already noticed this and uploaded a fixed branch earlier today.
> Should be ok tomorrow.
> 

Unfortunately that did not completely fix the problem, or maybe the fix got
lost. In mainline, when building alpha:allnoconfig:

arch/alpha/kernel/core_marvel.c:807:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'marvel_ioread8'
  807 | marvel_ioread8(const void __iomem *xaddr)

The code is:

unsigned u8
marvel_ioread8(const void __iomem *xaddr)

The compiler doesn't like "unsigned u8".

#regzbot ^introduced: e19d4ebc536d
#regzbot title: alpha:allnoconfig fails to build
#regzbot monitor: https://lore.kernel.org/linux-arch/202210062117.wJypzBWL-lkp@intel.com/

Guenter
