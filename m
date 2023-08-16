Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3880877ED59
	for <lists+linux-arch@lfdr.de>; Thu, 17 Aug 2023 00:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjHPWp1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Aug 2023 18:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347023AbjHPWpQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Aug 2023 18:45:16 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5591BF3;
        Wed, 16 Aug 2023 15:45:15 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-6471744acb6so20716816d6.1;
        Wed, 16 Aug 2023 15:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692225914; x=1692830714;
        h=content-transfer-encoding:subject:from:reply-to:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGoBkEwlCnbJad+CecbjRY+VjiJK8E7bojDgpjg7FvU=;
        b=J+2GZw9sDgAuPCvyYPqSvvzp1lVg6wE6qeMOlcYMGPuThPNLCGYiiW2dwFVq91l/vl
         NT/yeq5xZ4Ufc7IZxR6ugOwOZQfg5nMbUshmMxhNTewriji8eUuaNn0c360FPsW5tkH4
         6cS/vKC7K0l0lZLKGVqDi2VTUmRXgo+WSJJ9fOFjLJU7uhgHYQzddKm06zxNwf3BXFjN
         SCDUE56G1UeYAPYGs2dGSOsKeDDFiUZRdgQwqGIeL2NpPJhlcnrVVGytRXUYD0OF20a4
         87SE8XWZHMx/EGlk2yISP6pygxQx+aQ11VINZVZvJIAIyOIfvz+sxSaS9uqbom35csu9
         8sYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692225914; x=1692830714;
        h=content-transfer-encoding:subject:from:reply-to:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MGoBkEwlCnbJad+CecbjRY+VjiJK8E7bojDgpjg7FvU=;
        b=IdfiUe93j5zrAM96Wbfqu9C3bUaS2lEIwMNjBO7jUX3UKJi77wsulOXFdKjrYay6fB
         Te5+ljxaiBPW39YyshhCNVLcZLxKtNLXBjLRnSxUIZwolNP13yWdprCSuCWv6YxJ9jbr
         3fxtX3kPA9e2xwSdYmeLhmK7LDmhM6HWbT8xnB6bj7XpVTvOW1qfQBDnyxbIRezjUXI7
         KwbfWLtbj8ciZceTwvVMOcNhveiyNbMt/zhuxI8yIWMOps0Qkex5WPPp1wQBMn3MEGhK
         F32xD/iMffrxlJIXuIfYwEYP4A3m0Mi6K+Mpis5C2ybDh8FPHo7u9cpRDVKPPEyE1dEq
         +ROw==
X-Gm-Message-State: AOJu0YwuU7a0QZ7wJ6gOKoRE4BBCIvthiAdfGu6krXBQ9C3FcWaM+Vde
        yr5gBnyaeDZd5VcmK0pw2rg=
X-Google-Smtp-Source: AGHT+IFsHNXunRgp3X8hlKrWnp7WXFK/+sVXWgsvRCLnJDzFjNXPGtXcdWLNPeHWJ41d2OTBT7Z5iQ==
X-Received: by 2002:a0c:e4c7:0:b0:649:980c:4ee1 with SMTP id g7-20020a0ce4c7000000b00649980c4ee1mr1626603qvm.5.1692225914347;
        Wed, 16 Aug 2023 15:45:14 -0700 (PDT)
Received: from ?IPV6:2600:4040:57a3:100:5b2e:7da0:3ac1:56bd? ([2600:4040:57a3:100:5b2e:7da0:3ac1:56bd])
        by smtp.gmail.com with ESMTPSA id w13-20020a0ce10d000000b00645cbb3b6bbsm3864703qvk.115.2023.08.16.15.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 15:45:13 -0700 (PDT)
Message-ID: <38e1a01b-1e8b-7c66-bafc-fc5861f08da9@gmail.com>
Date:   Wed, 16 Aug 2023 18:45:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>, wireguard@lists.zx2c4.com,
        linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vgupta@kernel.org>,
        Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        linux-openrisc@vger.kernel.org, linux-mips@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Reply-To: 20230816055010.31534-1-rdunlap@infradead.org
From:   Jesse Taube <mr.bossman075@gmail.com>
Subject: Re: [PATCH] treewide: drop CONFIG_EMBEDDED
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Randy

 > diff -- a/init/Kconfig b/init/Kconfig
 > --- a/init/Kconfig
 > +++ b/init/Kconfig
 > @@ -1790,14 +1790,6 @@ config DEBUG_RSEQ
 >
 >  	  If unsure, say N.
 >
 > -config EMBEDDED
 > -	bool "Embedded system"
 > -	select EXPERT
 > -	help
 > -	  This option should be enabled if compiling the kernel for
 > -	  an embedded system so certain expert options are available
 > -	  for configuration.

Wouldn't removing this break many out of tree configs?
Should there be a warning here to update change it instead of removal?

Thanks,
Jesse Taube
