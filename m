Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218174E45D6
	for <lists+linux-arch@lfdr.de>; Tue, 22 Mar 2022 19:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237178AbiCVSTv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Mar 2022 14:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbiCVSTv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Mar 2022 14:19:51 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C6846644
        for <linux-arch@vger.kernel.org>; Tue, 22 Mar 2022 11:18:22 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id p9so24585901wra.12
        for <linux-arch@vger.kernel.org>; Tue, 22 Mar 2022 11:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod-ie.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Au0wuGbmyZQRc3YRooDi+lrIszQt6rNnlcrfEDXqtwM=;
        b=mXhuIMjn3uChtCcb9K8CZhFjjPYtbSBGn8NMsUNFxDideafXuSwJUpedM6R5NkuD41
         FWodwy/Zvv2BSJCJ6e32JpS18fFx7FY0lvk37TkItGCwdtB+yU5idyhXuiemVKE18V0C
         l0QquQJW2o06l3mJTYCKgD3MpzmwURJInuRHOM7HTvRdIxV6/dKbwY9BEuIJdlyqLswQ
         yu7D6bN6COkQhTMw+tRbDgkQycyMvHZLHG/AH8r/GHfE9g148SbWHA7YERGAvqYSLwn3
         v0FU5xXPaWOTSku+mt5Szj0T2gQQXoVEKOnOWDR7bAukdFSUyKm3n3XOLAHcO2q3zcsw
         dfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Au0wuGbmyZQRc3YRooDi+lrIszQt6rNnlcrfEDXqtwM=;
        b=z3xtDjpB3AhOI5Sgtnn9LUTCdBlQifR9k5qYjyokRJEnckk0WxnfJY/J9gZaNO4qHJ
         Gl/Y+9QsyzJ8XTNk+H0bCt9BTYP0UZbHTPcqoM6hK4qTdYLpsQHCc+mZ4X487gXpHMEY
         XFk1kgD88L9+8Ka6cH09fAY4N2WtihE/KD0CkjIKyMGWJKnvD2UtS4TPajh0Z7RDpWt4
         /i3ag/yDpiw0eisYkSpwYWTmxJiZTLgj0/Bw88MtAJdUGZOS/e8JYXRgvZxtYpqe7K6H
         xNlQBUVDyztHXUbhUcGlfG0Aw8bOC0/7mnuOOS6vOhf35vKvCNCO847SiTSBG0pnE0t2
         tgow==
X-Gm-Message-State: AOAM531ZzyqE1GeM90rWeXbStdVFth0t6ltLSNDsvFcdry7MkkNTdKZi
        XVD3/rQglFsbb++9T8R9oV6uHA==
X-Google-Smtp-Source: ABdhPJzo+v251N7F/kHeIIlbL9L7OkMaXL6JiW+aiVCl9WMXHup3N+5Shv6bcH5nGjpVfy+o5CVcdw==
X-Received: by 2002:adf:fe8d:0:b0:203:e02e:c6c7 with SMTP id l13-20020adffe8d000000b00203e02ec6c7mr23986364wrr.37.1647973101291;
        Tue, 22 Mar 2022 11:18:21 -0700 (PDT)
Received: from [192.168.2.116] ([109.76.4.19])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm11796069wrq.44.2022.03.22.11.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 11:18:20 -0700 (PDT)
Message-ID: <c0328672-6dd1-b65b-1e2f-6f2562084f2d@conchuod.ie>
Date:   Tue, 22 Mar 2022 18:18:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 0/5] Generic Ticket Spinlocks
Content-Language: en-US
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        linux-riscv@lists.infradead.org
Cc:     jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
        shorne@gmail.com, mingo@redhat.com, Will Deacon <will@kernel.org>,
        longman@redhat.com, boqun.feng@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, jszhang@kernel.org,
        wangkefeng.wang@huawei.com, openrisc@lists.librecores.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        peterz@infradead.org
References: <20220316232600.20419-1-palmer@rivosinc.com>
From:   Conor Dooley <mail@conchuod.ie>
In-Reply-To: <20220316232600.20419-1-palmer@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 16/03/2022 23:25, Palmer Dabbelt wrote:
> Peter sent an RFC out about a year ago
> <https://lore.kernel.org/lkml/YHbBBuVFNnI4kjj3@hirez.programming.kicks-ass.net/>,
> but after a spirited discussion it looks like we lost track of things.
> IIRC there was broad consensus on this being the way to go, but there
> was a lot of discussion so I wasn't sure.  Given that it's been a year,
> I figured it'd be best to just send this out again formatted a bit more
> explicitly as a patch.
> 
> This has had almost no testing (just a build test on RISC-V defconfig),
> but I wanted to send it out largely as-is because I didn't have a SOB
> from Peter on the code.  I had sent around something sort of similar in
> spirit, but this looks completely re-written.  Just to play it safe I
> wanted to send out almost exactly as it was posted.  I'd probably rename
> this tspinlock and tspinlock_types, as the mis-match kind of makes my
> eyes go funny, but I don't really care that much.  I'll also go through
> the other ports and see if there's any more candidates, I seem to
> remember there having been more than just OpenRISC but it's been a
> while.
> 
> I'm in no big rush for this and given the complex HW dependencies I
> think it's best to target it for 5.19, that'd give us a full merge
> window for folks to test/benchmark it on their systems to make sure it's
> OK.

Is there a specific way you have been testing/benching things, or is it 
just a case of test what we ourselves care about?

Thanks,
Conor.

> RISC-V has a forward progress guarantee so we should be safe, but
> these can always trip things up.
