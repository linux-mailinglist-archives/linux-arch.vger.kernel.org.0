Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBDC6B9B81
	for <lists+linux-arch@lfdr.de>; Tue, 14 Mar 2023 17:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjCNQbd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Mar 2023 12:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjCNQb1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Mar 2023 12:31:27 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845E73433A;
        Tue, 14 Mar 2023 09:31:26 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so5614994pjt.2;
        Tue, 14 Mar 2023 09:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678811486;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DEz24v95b0i34MGAg5Fg9f+XM78CDT3tIsiees5jA8c=;
        b=FtmIms2QxlCvzfuSI9XKKtM0r+aRAAPlD6p8eFrg/abi1XoWcBYo32u1/HXHTQFPly
         AeXuXleO7ZQCfwTtilrtyquOpAbReyhJgidtmq4VEYmDle4/HUozYgnU+P4MXGAcEeqO
         ztH9HWI8berKE2iJt3MWXHvK85+I1xC7wRE1IaG5xbmtn+FpLxOHclIF2masPdSUGrdk
         UAjYwnwUozzgiPVi1piQBp/JEF0d1swB95thc0zYlor3lH1KoTYhBkMdQGCQ9Zef6th1
         pTyROFbcqpNmte43uoPx7kJ9Ubm5zDHRBUtQmuYz9A+41XcyADTANA5x9VEvP+Fbl7yN
         QEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678811486;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DEz24v95b0i34MGAg5Fg9f+XM78CDT3tIsiees5jA8c=;
        b=TM07CTQkOlRemmQWx/aoEtIVfREI9jXI0BwXp8FPOiJo/6H+HHHqRFZuD7sLqG/Npi
         10bJv5/WkSuYq8f0lUQiQUJ9WbUYOhNpE0fZDj4/HsSngotBASrX3dFulvoJxI0K1hB7
         rBKZEYL2ciyjmKOWBd2FuMXti4VF1hsPSYCYvqewp03nbJvUAv1C1WNLC/phZEyXflfw
         88aX6mB9rCFWavSIW6zd54jRFKauDE2z8bmMCyZ0660+/Ei2Sg2+gNNge5y+fQPbcHJ0
         H/WM3ChISr6LNr6JAs0tV4o/7OvAk1V9qmgAQRfWhnBWz16wKtyIQ3SskuHEBUa5F9Tj
         h9gQ==
X-Gm-Message-State: AO0yUKWLpYIpnAbti6nYkuEiLRWysjgGhQruWassxDCqeW6eKqf0johe
        4jUNCrGYxIJ92EoNKXPfBxV+c4IUHjI=
X-Google-Smtp-Source: AK7set9tKnIoDzlI2PwH4ckA3AVJLIIUOHtwt4iLtNKPBoejQTCa81hLcA/vzkkWYXAYm7adoxZgDA==
X-Received: by 2002:a17:90b:4a12:b0:23d:7ae:6467 with SMTP id kk18-20020a17090b4a1200b0023d07ae6467mr7198889pjb.11.1678811485889;
        Tue, 14 Mar 2023 09:31:25 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id c1-20020a17090a490100b00233ccd04a15sm1922617pjh.24.2023.03.14.09.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 09:31:24 -0700 (PDT)
Message-ID: <7f39daad-05b0-46f8-bc89-185b336d8fd4@gmail.com>
Date:   Tue, 14 Mar 2023 09:31:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 2/4] mips: add <asm-generic/io.h> including
Content-Language: en-US
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, mpe@ellerman.id.au,
        geert@linux-m68k.org, mcgrof@kernel.org, hch@infradead.org,
        Helge Deller <deller@gmx.de>,
        Serge Semin <fancer.lancer@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org
References: <20230308130710.368085-1-bhe@redhat.com>
 <20230308130710.368085-3-bhe@redhat.com>
 <20230313175521.GA14404@alpha.franken.de> <ZA/iZHEHaQ2WR+HL@MiWiFi-R3L-srv>
 <20230314153421.GA13322@alpha.franken.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230314153421.GA13322@alpha.franken.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/14/23 08:34, Thomas Bogendoerfer wrote:
> On Tue, Mar 14, 2023 at 10:56:36AM +0800, Baoquan He wrote:
>> On 03/13/23 at 06:55pm, Thomas Bogendoerfer wrote:
>> ......
>>> /local/tbogendoerfer/korg/linux/include/linux/spinlock_api_smp.h:111:2: error: implicit declaration of function ‘LOCK_CONTENDED’ [-Werror=implicit-function-declaration]
>>>    LOCK_CONTENDED(lock, do_raw_spin_trylock, do_raw_spin_lock);
>>>    ^~~~~~~~~~~~~~
>>>    GEN     Makefile
>>>    Checking missing-syscalls for N32
>>>    CALL    /local/tbogendoerfer/korg/linux/scripts/checksyscalls.sh
>>>    Checking missing-syscalls for O32
>>>    CALL    /local/tbogendoerfer/korg/linux/scripts/checksyscalls.sh
>>>    CALL    /local/tbogendoerfer/korg/linux/scripts/checksyscalls.sh
>>>    CC      init/version.o
>>> In file included from /local/tbogendoerfer/korg/linux/include/linux/spinlock.h:311:0,
>>>                   from /local/tbogendoerfer/korg/linux/include/linux/vmalloc.h:5,
>>>                   from /local/tbogendoerfer/korg/linux/include/asm-generic/io.h:994,
>>>                   from /local/tbogendoerfer/korg/linux/arch/mips/include/asm/io.h:618,
>>>                   from /local/tbogendoerfer/korg/linux/include/linux/io.h:13,
>>>                   from /local/tbogendoerfer/korg/linux/arch/mips/include/asm/mips-cps.h:11,
>>>                   from /local/tbogendoerfer/korg/linux/arch/mips/include/asm/smp-ops.h:16,
>>>                   from /local/tbogendoerfer/korg/linux/arch/mips/include/asm/smp.h:21,
>>>                   from /local/tbogendoerfer/korg/linux/include/linux/smp.h:113,
>>>                   from /local/tbogendoerfer/korg/linux/include/linux/lockdep.h:14,
>>>                   from /local/tbogendoerfer/korg/linux/include/linux/rcupdate.h:29,
>>>                   from /local/tbogendoerfer/korg/linux/include/linux/rculist.h:11,
>>>                   from /local/tbogendoerfer/korg/linux/include/linux/pid.h:5,
>>>                   from /local/tbogendoerfer/korg/linux/include/linux/sched.h:14,
>>>                   from /local/tbogendoerfer/korg/linux/include/linux/utsname.h:6,
>>>                   from /local/tbogendoerfer/korg/linux/init/version.c:17:
>>> /local/tbogendoerfer/korg/linux/include/linux/spinlock_api_smp.h: In function ‘__raw_spin_trylock’:
>>> /local/tbogendoerfer/korg/linux/include/linux/spinlock_api_smp.h:90:3: error: implicit declaration of function ‘spin_acquire’ [-Werror=implicit-function-declaration]
>>>     spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
>>>     ^~~~~~~~~~~~
>>> /local/tbogendoerfer/korg/linux/include/linux/spinlock_api_smp.h:90:21: error: ‘raw_spinlock_t {aka struct raw_spinlock}’ has no member named ‘dep_map’
>>>     spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
>>>                       ^~
>>> /local/tbogendoerfer/korg/linux/include/linux/spinlock_api_smp.h: In function ‘__raw_spin_lock_irqsave’:
>>> /local/tbogendoerfer/korg/linux/include/linux/spinlock_api_smp.h:110:20: error: ‘raw_spinlock_t {aka struct raw_spinlock}’ has no member named ‘dep_map’
>>>    spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
>>>                      ^~
>>> /local/tbogendoerfer/korg/linux/include/linux/spinlock_api_smp.h:111:2: error: implicit declaration of function ‘LOCK_CONTENDED’ [-Werror=implicit-function-declaration]
>>>    LOCK_CONTENDED(lock, do_raw_spin_trylock, do_raw_spin_lock);
>>>    ^~~~~~~~~~~~~~
>>> [...]
>>>
>>> I've cut the compiler output. Removing the asm-generic doesn't show this
>>> problem, but so far I fail to see the reason...
>>
>> Thanks for trying this.
>>
>> Do you have the kernel config file, I can try to reproduce on my local
>> machine. And by the way, it could be fixed with below patch, not very
>> sure. Earlier, Arnd suggested this to fix a similar case.
> 
> already tried it, but it doesn't fix the issue. I've attached the
> config.

I had attempted a similar approach before as Baoquan did, but met the 
same build issue as Thomas that was not immediately clear to me why it 
popped up. I would be curious to see how this can be resolved.
-- 
Florian

