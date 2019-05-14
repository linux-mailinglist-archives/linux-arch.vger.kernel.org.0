Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 339181E568
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2019 01:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfENXDL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 May 2019 19:03:11 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44188 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfENXDL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 May 2019 19:03:11 -0400
Received: by mail-pl1-f193.google.com with SMTP id c5so311702pll.11;
        Tue, 14 May 2019 16:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4xuOhafijhTBKjPcHvwICr8fCf3XDF6k7moLbg3FXwg=;
        b=f+iki57StuAV+FkmK28LEJUx6eRLXHSLyK478LBU5ugMCQKEKAZdX23XdU0hTop3GI
         xGJewyrbS+bCN0qDv8n7PLgw3R8cXpE0K/wG2jRzQacmvbhYfW7oSLUF0VZeH68ddsoC
         qCNTE4tz3BD6ag5z4FRz+GrqR1A+UYG9qKbww7xnZsjPhVhqd+6O8objP/SAgY/BQF1Q
         ivbwlEgshLeExC9RVBfCEAUIXWs05qZfaYgSJfxqkwNiFZ85iJBc25BjSEsCaj8LJ185
         thGVy5+SA6YMXpJunfpxoxvi7Ld/QsAGJr58tOGd2mFNOsejpsJWS0s/mxLb0Izfo4iT
         76Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4xuOhafijhTBKjPcHvwICr8fCf3XDF6k7moLbg3FXwg=;
        b=b8VSCG2DEf4t8R2wEAGIfJSF4EQUNBIH/JgRKqv/Zl+I3t0bsd1Ya851h1lsGwITOn
         Zf7cVmYtFfAW6yMeBSxi/OyThJrZeKcLCezpph7gLzIkFfNYMqqyXcCl8tzNej+B8Dyr
         3tRGNHLd2+ajuccWRvjRsP7HEwf34iintT6MuYSPYz/DZghkb+/7z4N1+C8WLKAqyrLZ
         C2xkpSn17MmmtmQ19DPyfQG4O1pVcFdzeKGuHYDElLsdUnz+K1GG59q0B5z7g1ntDCKy
         2o9o1ZRF3yjuZUdyYk38/UtiXzQBbQejO+BxE5Bp9lqB32C+s/iLfgZ0J3UTKIub3sB5
         lBsA==
X-Gm-Message-State: APjAAAUOI13e5i5A8NB8cULdC95vGU44RKSmuHR3avVhONfM9q1m8EPI
        YY12xSbzROj9HEBWavnflak=
X-Google-Smtp-Source: APXvYqy3fmo7/ncm6lIHtrFpfQoSewVnPVoZDijQHrQxC4R9KBEXyV2Q9ZJU/PMMxrsLSU8w/4pXOg==
X-Received: by 2002:a17:902:5983:: with SMTP id p3mr38930332pli.224.1557874990361;
        Tue, 14 May 2019 16:03:10 -0700 (PDT)
Received: from localhost ([2601:640:5:a19f:19d3:11c4:475e:3daa])
        by smtp.gmail.com with ESMTPSA id l65sm238391pfb.7.2019.05.14.16.03.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 16:03:09 -0700 (PDT)
Date:   Tue, 14 May 2019 16:01:58 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     Yuri Norov <ynorov@marvell.com>, Andreas Schwab <schwab@suse.de>,
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
Message-ID: <20190514230158.GA6780@yury-thinkpad>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
 <20190508225900.GA14091@yury-thinkpad>
 <mvmtvdyoi33.fsf@suse.de>
 <MN2PR18MB30865B950D85C6463EB0E1D4CB0F0@MN2PR18MB3086.namprd18.prod.outlook.com>
 <20190514104311.GA24708@rei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514104311.GA24708@rei>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 14, 2019 at 12:43:11PM +0200, Cyril Hrubis wrote:
> Hi!
> > > There is a problem with the stack size accounting during execve when
> > > there is no stack limit:
> > >
> > > $ ulimit -s
> > > 8192
> > > $ ./hello.ilp32 
> > > Hello World!
> > > $ ulimit -s unlimited
> > > $ ./hello.ilp32 
> > > Segmentation fault
> > > $ strace ./hello.ilp32 
> > > execve("./hello.ilp32", ["./hello.ilp32"], 0xfffff10548f0 /* 77 vars */) = -1 ENOMEM (Cannot allocate memory)
> > > +++ killed by SIGSEGV +++
> > > Segmentation fault (core dumped)
> > >
> > > Andreas.
> > 
> > Thanks Andreas, I will take a look. Do we have such test in LTP?

So the problem was in not converting new compat-sensitive code:

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 5bdf357169d8..c509f83fa506 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -63,7 +63,7 @@
 				TASK_SIZE_32 : TASK_SIZE_64)
 #define TASK_SIZE_OF(tsk)	(is_compat_thread(tsk) ? \
 				TASK_SIZE_32 : TASK_SIZE_64)
-#define DEFAULT_MAP_WINDOW	(test_thread_flag(TIF_32BIT) ? \
+#define DEFAULT_MAP_WINDOW	(is_compat_task() ? \
 				TASK_SIZE_32 : DEFAULT_MAP_WINDOW_64)
 #else
 #define TASK_SIZE		TASK_SIZE_64

The fix is incorporated in ilp32-5.1.1:
https://github.com/norov/linux/tree/ilp32-5.1.1

> We do have a test that we can run a binary with very small stack size
> i.e. 512kB but there does not seem to be anything that would catch this
> specific problem.
> 
> Can you please open an issue and describe how to reproduce the problem
> at our github tracker:
> 
> https://github.com/linux-test-project/ltp/issues
> 
> Then we can create testcase based on that reproducer later on.
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

OK, I'll do.

Yury
