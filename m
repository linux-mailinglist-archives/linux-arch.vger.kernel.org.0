Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0624A63DEF
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2019 00:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfGIWmp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Jul 2019 18:42:45 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38709 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfGIWmo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jul 2019 18:42:44 -0400
Received: by mail-pg1-f196.google.com with SMTP id z75so175406pgz.5;
        Tue, 09 Jul 2019 15:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EnQW9i20df0zx3M6tQh/RXiMIwRQmZ5+hWLyjYA/FdM=;
        b=DD0AQXo7JMl/6LPkpiSOoXmJvtk0qrVJHBq8NWlJXgANSN9l8CYGHoEAX+Cg88pCHo
         TjMtn/CAJnppHWLIVz6IGlqKuRg9mx2vSLtavvneT2TSfEmj31fdZW1RV/CGU9cg9feM
         LFd8+qBvS2j4Q+F4zPaw9pKQ+w2UqTz6Gi9eSWRLAOsCs8/F/nHXqk/RhMtZIImDO9kn
         qoroYl8z7mi57bbK3gsqZQC5gXEFa7fs6PBen9hSbEgYL9D4FLsV9sKg2tuF6f8LmUNa
         U4XZXl4CbpMCgLpIjrWMldNTqZk4e9T6M1phfKBqPUCln+P90FeXwVX5AuosNREIy2vd
         X4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EnQW9i20df0zx3M6tQh/RXiMIwRQmZ5+hWLyjYA/FdM=;
        b=b5MPLNHnwkGz/Sid3/C/1hkWopzvjCrHA8gBA7qhH7vaafdoHCRa60MoCMq2K2c47v
         TqXjBUmKZ+eHM0wXfRG05BRrTNZjMDJraAc32U3EHsU3K1bmLdEzHK/we0mSl267yhJE
         AXcyiWaaMuZ68CyDJI/5ctaAxKWKOCGIA64+vopmdE1L7Ubk5amDaOneCj1dS6niI+UY
         1wc6vnftLc076T7jAjyEwyaV/k/52u7I80o3IZRU2F58RkdWVOX36c4oYP1zBP0QsWVK
         iVtCvFED9yNC1TSUpC9+7t0La0khiodSPPsGUMNkSVLmi+RX0iO5/B66CO6uhsNwzYIy
         W7gA==
X-Gm-Message-State: APjAAAWGNOA7mDGM+iPDq/31reR7dH70vFdjskVkUKzIDnw6vtljRKRP
        oRipjosmyHpQYwL1F0iIa/g=
X-Google-Smtp-Source: APXvYqzWIHWAc0izqtDS4qxFCC/slE9GIKp9Zy4uf+1dCpoSZl/0jGEsHCMr1DHfkCHmu5CfiqPWOw==
X-Received: by 2002:a17:90a:20a2:: with SMTP id f31mr2745143pjg.90.1562712163888;
        Tue, 09 Jul 2019 15:42:43 -0700 (PDT)
Received: from localhost ([2607:f140:6000:1f:f5fc:878f:592:306])
        by smtp.gmail.com with ESMTPSA id t9sm141136pji.18.2019.07.09.15.42.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 15:42:43 -0700 (PDT)
Date:   Tue, 9 Jul 2019 15:42:41 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Yury Norov <ynorov@caviumnetworks.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, Adam Borowski <kilobyte@angband.pl>,
        Alexander Graf <agraf@suse.de>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andreas Schwab <schwab@suse.de>,
        Andrew Pinski <pinskia@gmail.com>,
        Bamvor Zhangjian <bamv2005@gmail.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Dave Martin <Dave.Martin@arm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Florian Weimer <fweimer@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        James Hogan <james.hogan@imgtec.com>,
        James Morse <james.morse@arm.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Lin Yongting <linyongting@huawei.com>,
        Manuel Montezelo <manuel.montezelo@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Nathan_Lynch <Nathan_Lynch@mentor.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Steve Ellcey <sellcey@caviumnetworks.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>
Subject: Re: [PATCH v9 00/24] ILP32 for ARM64
Message-ID: <20190709224241.GA28503@yury-thinkpad>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516081910.10067-1-ynorov@caviumnetworks.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

On Wed, May 16, 2018 at 11:18:45AM +0300, Yury Norov wrote:
> This series enables AARCH64 with ILP32 mode.
> 
> As supporting work, it introduces ARCH_32BIT_OFF_T configuration
> option that is enabled for existing 32-bit architectures but disabled
> for new arches (so 64-bit off_t userspace type is used by new userspace).
> Also it deprecates getrlimit and setrlimit syscalls prior to prlimit64.
> 
> Based on kernel v4.16. Tested with LTP, glibc testsuite, trinity, lmbench,
> CPUSpec.
> 
> This series on github: 
> https://github.com/norov/linux/tree/ilp32-4.16
> Linaro toolchain:
> http://snapshots.linaro.org/components/toolchain/binaries/7.3-2018.04-rc1/aarch64-linux-gnu_ilp32/
> Debian repo:
> http://people.linaro.org/~wookey/ilp32/
> OpenSUSE repo:
> https://build.opensuse.org/project/show/devel:ARM:Factory:Contrib:ILP32
> 
> Changes:
> v3: https://lkml.org/lkml/2014/9/3/704
> v4: https://lkml.org/lkml/2015/4/13/691
> v5: https://lkml.org/lkml/2015/9/29/911
> v6: https://lkml.org/lkml/2016/5/23/661
> v7: https://lkml.org/lkml/2017/1/9/213
> v8: https://lkml.org/lkml/2017/6/19/624
> v9: - rebased on top of v4.16;
>     - signal subsystem reworked to avoid code duplication, as requested
>       by Dave Martin (patches 18 and 20);
>     - new files introduced in series use SPDX notation for license;
>     - linux-api and linux-arch CCed as the series changes kernel ABI;
>     - checkpatch and other minor fixes.
>     - Zhou Chengming's reported-by for patch 2 and signed-off-by for
>       patch 21 removed because his email became invalid. Zhou, please
>       share your new email.

This is a 5.2-based version of series.
https://github.com/norov/linux/tree/ilp32-5.2

Thanks,
Yury
