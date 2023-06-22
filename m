Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9231773AC6A
	for <lists+linux-arch@lfdr.de>; Fri, 23 Jun 2023 00:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjFVWQz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jun 2023 18:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjFVWQz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jun 2023 18:16:55 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8041BE2
        for <linux-arch@vger.kernel.org>; Thu, 22 Jun 2023 15:16:53 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-62ffb475be0so59778046d6.2
        for <linux-arch@vger.kernel.org>; Thu, 22 Jun 2023 15:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1687472213; x=1690064213;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K8ZqC2RcIKWzE1RcjLIH4d+Je5CLfsvEiug0JY8wdLY=;
        b=cQtriItXNiJ4pagxKqXEHN8Beu9yKDP7qXyi8/z0i500MAXA386GICymtBIvuqxZlt
         HNkztwcOoRkmmOOpCpaANaIy3nVWjHA4bzlnM8VyN17MU0wYjOhP1V+EkNOEFt2nStmK
         zko5stS09ow0hnv6o4xiQ6dWvxvvd/9PUbQmtI31ezlrJ5K/GOrIO7uTie0LUxG1e/jB
         ctM0b29oJSmUGT4hueJ9yQYWNRybOznFXHhG5xuQrinEsJi10Zke2MPHEVpqzzQQdd17
         qxxddLLBciEBk5VVM3UCzba+4/w8GKfJm0t/fOhQvb3IGO9xVfrQtU9yY7vJNPjibZoG
         l2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687472213; x=1690064213;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8ZqC2RcIKWzE1RcjLIH4d+Je5CLfsvEiug0JY8wdLY=;
        b=fUzxTwEcok2p0uoIAw2EaJ521PyEzAPCQhjYi83A+4mHvvtAP3Rav3Z7/vbqp89SMJ
         /IVlV5hKhXueXQBIcv1cdCzt2vUsoh35oo/4xGkVBf+mdyzO2wiT7+PmrFua82FETxLq
         eZDNX1RVwY9BqAFISaQoSfNNhfAVlqcQpfze5CjvYSapkS3GOPICgUJ+MwArXi/JHNaX
         UjnuRleaCMAZSicLKf2r11k/Pabpl3E1GqmDSmOpQcE9g+ZqrcO3efeeLpbwkMHY4p9l
         xW6rtnSl0Pohzu/YtFa2C0nwHD2a/lOKT63Pe4o+MB8Wx1toiBUg7Jr/mPuaNVoJwNcJ
         kI6w==
X-Gm-Message-State: AC+VfDxnyjpXjaSaoTmMMoe77nwUbTZ1/9lsI5DG/6DcaMKPtVyF2H5l
        oynpUHdin2DGo+haEq1oPwAn1g==
X-Google-Smtp-Source: ACHHUZ78o3J4G8akIl5xWlqpuHc0moKjGn3VopxJePyibqO3GkUL16bRdu5C0ffHAO9b/mOh8sFVzg==
X-Received: by 2002:a05:6214:4111:b0:62d:eb54:5f4d with SMTP id kc17-20020a056214411100b0062deb545f4dmr20980418qvb.38.1687472212693;
        Thu, 22 Jun 2023 15:16:52 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id o17-20020a634e51000000b0052c3f0ae381sm5266124pgl.78.2023.06.22.15.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 15:16:51 -0700 (PDT)
Date:   Thu, 22 Jun 2023 15:16:51 -0700 (PDT)
X-Google-Original-Date: Thu, 22 Jun 2023 15:16:10 PDT (-0700)
Subject:     Re: [PATCH v2 0/4] riscv: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
In-Reply-To: <20230622215327.GA1135447@dev-arch.thelio-3990X>
CC:     bjorn@kernel.org, ndesaulniers@google.com,
        Conor Dooley <conor@kernel.org>, jszhang@kernel.org,
        llvm@lists.linux.dev, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     nathan@kernel.org
Message-ID: <mhng-6c34765c-126d-4e6c-8904-e002d49a4336@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 22 Jun 2023 14:53:27 PDT (-0700), nathan@kernel.org wrote:
> On Wed, Jun 21, 2023 at 11:19:31AM -0700, Palmer Dabbelt wrote:
>> On Wed, 21 Jun 2023 10:51:15 PDT (-0700), bjorn@kernel.org wrote:
>> > Conor Dooley <conor@kernel.org> writes:
>> >
>> > [...]
>> >
>> > > > So I'm no longer actually sure there's a hang, just something
>> > > > slow.  That's even more of a grey area, but I think it's sane to
>> > > > call a 1-hour link time a regression -- unless it's expected
>> > > > that this is just very slow to link?
>> > >
>> > > I dunno, if it was only a thing for allyesconfig, then whatever - but
>> > > it's gonna significantly increase build times for any large kernels if LLD
>> > > is this much slower than LD. Regression in my book.
>> > >
>> > > I'm gonna go and experiment with mixed toolchain builds, I'll report
>> > > back..
>> >
>> > I took palmer/for-next (1bd2963b2175 ("Merge patch series "riscv: enable
>> > HAVE_LD_DEAD_CODE_DATA_ELIMINATION"")) for a tuxmake build with llvm-16:
>> >
>> >   | ~/src/tuxmake/run -v --wrapper ccache --target-arch riscv \
>> >   |     --toolchain=llvm-16 --runtime docker --directory . -k \
>> >   |     allyesconfig
>> >
>> > Took forever, but passed after 2.5h.
>>
>> Thanks.  I just re-ran mine 17/trunk LLD under time (rather that just
>> checking top sometimes), it's at 1.5h but even that seems quite long.
>>
>> I guess this is sort of up to the LLVM folks: if it's expected that DCE
>> takes a very long time to link then I'm not opposed to allowing it, but if
>> this is probably a bug in LLD then it seems best to turn it off until we
>> sort things out over there.
>>
>> I think maybe Nick or Nathan is the best bet to know?
>
> I can confirm a regression with allyesconfig but not allmodconfig using
> LLVM 16.0.6 on my 80-core Ampere Altra system.
>
> allmodconfig: 8m 4s
> allmodconfig + CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=n: 7m 4s
> allyesconfig: 1h 58m 30s
> allyesconfig + CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=n: 12m 41s

Are those backwards?  I'm getting super slow builds after merging the 
patch set, not before -- though apologize in advance if I'm reading it 
wrong, I'm well on my way to falling asleep already ;)

> I am sure there is something that ld.lld can do better, given GNU ld
> does not have any problems as earlier established, so that should
> definitely be explored further. I see Nick already had a response about
> writing up a report (I wrote most of this before that email so I am
> still sending this one).
>
> However, allyesconfig is pretty special and not really indicative of a
> "real world" kernel build in my opinion (which will either be a fully
> modular kernel to allow use on a wide range of hardware or a monolithic
> kernel with just the drivers needed for a specific platform, which will
> be much smaller than allyesconfig); it has given us problems with large
> kernels before on other architectures.

I totally agree that allyesconfig is an oddity, but it's something that 
does get regularly build tested so a big build time hit there is going 
to cause trouble -- maybe not for users, but it'll be a problem for 
maintainers and that's way more likely to get me yelled at ;)

> CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is already marked with 'depends on
> EXPERT' and its help text mentions its perils, so it does not seem
> unreasonable to me to add an additional dependency on !COMPILE_TEST so
> that allmodconfig and allyesconfig cannot flip this on, something like
> the following perhaps?
>
> diff --git a/init/Kconfig b/init/Kconfig
> index 32c24950c4ce..25434cbd2a6e 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1388,7 +1388,7 @@ config HAVE_LD_DEAD_CODE_DATA_ELIMINATION
>  config LD_DEAD_CODE_DATA_ELIMINATION
>  	bool "Dead code and data elimination (EXPERIMENTAL)"
>  	depends on HAVE_LD_DEAD_CODE_DATA_ELIMINATION
> -	depends on EXPERT
> +	depends on EXPERT && !COMPILE_TEST
>  	depends on $(cc-option,-ffunction-sections -fdata-sections)
>  	depends on $(ld-option,--gc-sections)
>  	help
>
> If applying that dependency to all architectures is too much, the
> selection in arch/riscv/Kconfig could be gated on the same condition.

Is the regression for all ports, or just RISC-V?  I'm fine gating this 
with some sort of Kconfig flag, if it's just impacting RISC-V then it 
seems sane to keep it over here.

> Cheers,
> Nathan
