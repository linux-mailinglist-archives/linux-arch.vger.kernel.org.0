Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D55C1E5AA
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2019 01:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfENXlx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 May 2019 19:41:53 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34680 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfENXlw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 May 2019 19:41:52 -0400
Received: by mail-pg1-f193.google.com with SMTP id c13so353950pgt.1;
        Tue, 14 May 2019 16:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DY6OWxXL6Mkjdnz9bKItmOBCwg7lWspCryDrZpJJELw=;
        b=X4mfkQznNYHZpXmFQYc7WK7z6OUmo6Sk25Nz/vjKV2dkhuYPBTUE6ya8Uuvkk/gBjh
         yA9ixJsoOl6ZMN9xYtfiFtg3vHtMFGQ1iOyOf+mqu3wjSEummwRW/BRDCd+QtgiQZPHj
         pa7E7QrakEnijd59IO6EK+x0NSpSwHa5cORHnMYA76qNEjYcLFOmQ1p30SGuBQR708zp
         CygDrnfb/RYOSwMJwPiynqo8DLa4PyaW8HtNT/zDcyu4TUn3xmi3AVBPGtHTxz+qem38
         Nxe3M+AbbxfJsYvo5uXQMhJnOobYuVgUeifiaAKUUDLjXnmhcvT22u4FH00JEvinEmNk
         a4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DY6OWxXL6Mkjdnz9bKItmOBCwg7lWspCryDrZpJJELw=;
        b=MhFrLICxYeyG1sLxG005khR4XzbPUPvwVaSGdLkhQB2LPSbri+aCSuL2DEAAWDIncm
         whd+FefsCD6Tv+74PyJ6vg9wwbPGuEzOL8a2/g/6Z8QkTHbC1dOBC/zthloX3/f3sT40
         4wDaM+jeawho9E5SSUhwYm6lyAMoYNZVyha2Ix6VQlL/7TMLMcTEtumUkjPylo1MJCn+
         5Z2Eu/ug9TMLNToS0D5r/GZrqV637UihhUL/oTeIhlh1duTbbW4Q7e61f8H9TSzx969t
         II5nfyi2ZBq40sZ24GfrZs6HDw7XQfLstKB0qD2tU2KYH8YeqhAveUeuwL1UyDZ2UgWu
         8CZQ==
X-Gm-Message-State: APjAAAXVlRbOpSeBT53jmiW0GQMhHP/Yn8WWB/xupgMlWR40yEx8V6yI
        3D1aQBHUu0gVHeZ1lmtt3Go=
X-Google-Smtp-Source: APXvYqwNBpkrVnbSQYAwgohdGmjunNQdCGyoDBa+JV+/+DN57azD9XaTe7h6TpYw5x0TTy4MoQNjgQ==
X-Received: by 2002:a63:4346:: with SMTP id q67mr40722725pga.241.1557877311862;
        Tue, 14 May 2019 16:41:51 -0700 (PDT)
Received: from localhost ([2601:640:5:a19f:19d3:11c4:475e:3daa])
        by smtp.gmail.com with ESMTPSA id u123sm290199pfu.67.2019.05.14.16.41.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 16:41:51 -0700 (PDT)
Date:   Tue, 14 May 2019 16:41:49 -0700
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
Message-ID: <20190514234149.GA12077@yury-thinkpad>
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
> 
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

This is it:
https://github.com/linux-test-project/ltp/issues/530

Yury
