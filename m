Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC3E31827F
	for <lists+linux-arch@lfdr.de>; Thu,  9 May 2019 00:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbfEHW7D (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 May 2019 18:59:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40898 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbfEHW7D (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 May 2019 18:59:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id u17so210289pfn.7;
        Wed, 08 May 2019 15:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3skeGRJ5pRr7+D0+GcBeYq1z7ba6TiYFkEy56aNuN4w=;
        b=f6E0Q9JV/oK81qEUGBzLotW8ivaqqSHQj7zCw/2vC4n6WMxqICOe4J18CGHEnErqml
         8wbXgFKBwRG1uwSDnr5Nkn/yCLqp0wlAiItz+AYTS7CWrdy3bMeTFC0yXK4CkYMks5yS
         qQqA5u3k0/MIGmqy5d0sr/1l+9LuLYarLCbc3pZhwmpX2Emen/uTBbGAbtd0Sj5FXEaX
         A3Tf/jGtFYql7ptoRop4ZSC4OQxhjEzN5jZ1VD4upkNn8MJoDEc31FtjJ3ZJmAWtNTas
         B0DgM3KudTDi1acsEkSoFtPV66r3dP+Ak6uPJLO8/hT9sfmFREvZkxJ6qmkjWjC7axjn
         2s/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3skeGRJ5pRr7+D0+GcBeYq1z7ba6TiYFkEy56aNuN4w=;
        b=n1usrSXd36sRvrrDOMuXyl5P/DkJq7uK/sYBru4E3db4m+lJwqPdqMHannh3dTR7PT
         Qy6SKIEMzEMveQNr6j4C3//6EFzamgaO+wmd3/+5x/+GO+RYL0GyRbSb6/ncpL8r97db
         Wfntpr/K8CJp3M5ohwR20NKUxJCx88jA5KouK//7NgCE0KjHUa+gj1KV4BiNZhS3C+G6
         3V/T+qhMcnN4SCAYexa/g4ND422BneztFzX0WgMy+2ufs83bfoZYYC1nLXRYxb2yssE7
         8PiyFNJdQKGSevF67bSHXNPyPJwX5UnE8Z37Uhu8DFiN+1V1pfCU8P8CBWTOtSuOw02P
         PvRw==
X-Gm-Message-State: APjAAAXD97/6rs2Gqe3SFipR0jqEKO9cMpFsePL808kEN/xtq6hsBjZc
        ASL6MoIup4HqEayfrBo7eXI=
X-Google-Smtp-Source: APXvYqyrohy1M3ppdW6lU7eKE2owmntyLl4B+K6DHGaWoh7InMPIPpSi5AI1dedYXt/CdhdeAcHu/g==
X-Received: by 2002:a63:6f8e:: with SMTP id k136mr969393pgc.104.1557356342554;
        Wed, 08 May 2019 15:59:02 -0700 (PDT)
Received: from localhost ([2601:640:0:ebed:19d3:11c4:475e:3daa])
        by smtp.gmail.com with ESMTPSA id i65sm327948pgc.3.2019.05.08.15.59.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 15:59:01 -0700 (PDT)
Date:   Wed, 8 May 2019 15:59:00 -0700
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
Message-ID: <20190508225900.GA14091@yury-thinkpad>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516081910.10067-1-ynorov@caviumnetworks.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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

This is the 5.1-based version.
Changes comparing to 5.0:
 - drop arch patches that has been taken upstream:
   80d7da1cac62 asm-generic: Drop getrlimit and setrlimit syscalls from default list
   942fa985e9f1 32-bit userspace ABI: introduce ARCH_32BIT_OFF_T config option
   0d0216c03a7a compat ABI: use non-compat openat and open_by_handle_at variants
 - in include/linux/thread_bits.h define current_thread_info() prior to
   inclusion of asm/thread_info.h, to avoid circullar dependencies (thread: move
   thread bits accessors to separated file);
 - enable old IPC interfaces for ilp32, according to mainline changes
   (arm64: ilp32: introduce syscall table for ILP32).

Thanks,
Yury
