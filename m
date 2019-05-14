Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35E251C725
	for <lists+linux-arch@lfdr.de>; Tue, 14 May 2019 12:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfENKnQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 May 2019 06:43:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:39300 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725893AbfENKnQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 May 2019 06:43:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D4BF7AC3F;
        Tue, 14 May 2019 10:43:13 +0000 (UTC)
Date:   Tue, 14 May 2019 12:43:11 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Yuri Norov <ynorov@marvell.com>
Cc:     Andreas Schwab <schwab@suse.de>, Yury Norov <yury.norov@gmail.com>,
        "ltp@lists.linux.it" <ltp@lists.linux.it>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Joseph Myers <joseph@codesourcery.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Steve Ellcey <sellcey@caviumnetworks.com>,
        Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>,
        Alexander Graf <agraf@suse.de>,
        Bamvor Zhangjian <bamv2005@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Adam Borowski <kilobyte@angband.pl>,
        Manuel Montezelo <manuel.montezelo@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Pinski <pinskia@gmail.com>,
        Lin Yongting <linyongting@huawei.com>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Nathan_Lynch <Nathan_Lynch@mentor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>
Subject: Re: [LTP] [EXT] Re: [PATCH v9 00/24] ILP32 for ARM64
Message-ID: <20190514104311.GA24708@rei>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
 <20190508225900.GA14091@yury-thinkpad>
 <mvmtvdyoi33.fsf@suse.de>
 <MN2PR18MB30865B950D85C6463EB0E1D4CB0F0@MN2PR18MB3086.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR18MB30865B950D85C6463EB0E1D4CB0F0@MN2PR18MB3086.namprd18.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi!
> > There is a problem with the stack size accounting during execve when
> > there is no stack limit:
> >
> > $ ulimit -s
> > 8192
> > $ ./hello.ilp32 
> > Hello World!
> > $ ulimit -s unlimited
> > $ ./hello.ilp32 
> > Segmentation fault
> > $ strace ./hello.ilp32 
> > execve("./hello.ilp32", ["./hello.ilp32"], 0xfffff10548f0 /* 77 vars */) = -1 ENOMEM (Cannot allocate memory)
> > +++ killed by SIGSEGV +++
> > Segmentation fault (core dumped)
> >
> > Andreas.
> 
> Thanks Andreas, I will take a look. Do we have such test in LTP?

We do have a test that we can run a binary with very small stack size
i.e. 512kB but there does not seem to be anything that would catch this
specific problem.

Can you please open an issue and describe how to reproduce the problem
at our github tracker:

https://github.com/linux-test-project/ltp/issues

Then we can create testcase based on that reproducer later on.

-- 
Cyril Hrubis
chrubis@suse.cz
