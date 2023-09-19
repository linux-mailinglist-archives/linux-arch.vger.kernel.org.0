Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428807A6A62
	for <lists+linux-arch@lfdr.de>; Tue, 19 Sep 2023 20:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjISSFA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Sep 2023 14:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjISSE7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Sep 2023 14:04:59 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A8C90
        for <linux-arch@vger.kernel.org>; Tue, 19 Sep 2023 11:04:53 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-690d9cda925so48862b3a.3
        for <linux-arch@vger.kernel.org>; Tue, 19 Sep 2023 11:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695146692; x=1695751492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=15nBqosj6WWJOSwWn2FB/oN1SFdvM0QLlK2aSBEvitc=;
        b=wQEV+xKZafjXjnlwLYpplDcXlrUvvdo9PftzaxGLMNVWiXvH8pAipV6QzTp0t/wd9T
         eJw5q/qoBNeA+CyvHeNqcUPwvUW3vvuxG5woLdjz4m12evMc7KLNu/tpyS0WiW3WyWkW
         +4mkNwHfkxeJQAqtJG63+qcCVt0zScPqI03/WnuLpXf5lYRbaVZp3s13LpuSsHg6wZRi
         AUePJvYLcepVewf/lpikp5D1VrwjMKm91yVtGT3fjh0rE0782hsq4VhaDa4Eh+PS1G2v
         54kwrkke/MWSIHs+xSeR90vE77mxllLbgsZ0BhvTvmC6Vmh/YfYlQUlIiHCh8L6re9um
         qJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695146692; x=1695751492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15nBqosj6WWJOSwWn2FB/oN1SFdvM0QLlK2aSBEvitc=;
        b=TjxvoMaX38TaqpNsgSnuZGPSenefSEmqjSNQ1RDMNKz3I7WdaiK5J8UelYKRtvF/R/
         iSCXouboArDC6Vchbwvhm0LZeglZsddkTwpudEqWeOeHCU3Wa8Gw5Obr4kT6WIEYDAb0
         3CZc9tni7gECVHS9gKX1SdkogLwXZ3rQBr061/O6ZjKktY3aQCqysh30RnPv6hyMR58a
         5l1pnCWmG91c5ZiV7Z3s9+AKpxsvB4HW39mfMTnC6XvYoW/hq/KE4FB+QW3QmCFFf3lA
         w/R0TomZA+03KdMaahKpxpBZcY8S3C7QhV/UXXZhL/L0my3W5hg0TRiMr35QDPYYn+PV
         +/gw==
X-Gm-Message-State: AOJu0YzFnep65vRLWGZ2SNQGjX/MOOAc4+ydj4agcaMqQgAJMX0sDXms
        CpiPiQpUP8u16znTSpsGXFdVuriNsqMJjzjy2TA=
X-Google-Smtp-Source: AGHT+IFn+Y/cGWo27YQI4ilcWAzwa2ujC73b21l2AUPxDC9BANzyouOgE1tnupcGIzbju5oTcBbyWg==
X-Received: by 2002:a05:6a00:179f:b0:690:1720:aa9a with SMTP id s31-20020a056a00179f00b006901720aa9amr446773pfg.15.1695146692638;
        Tue, 19 Sep 2023 11:04:52 -0700 (PDT)
Received: from ghost ([50.168.177.76])
        by smtp.gmail.com with ESMTPSA id a23-20020a62e217000000b00666e649ca46sm8947951pfi.101.2023.09.19.11.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 11:04:52 -0700 (PDT)
Date:   Tue, 19 Sep 2023 14:04:48 -0400
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 3/4] riscv: Add checksum library
Message-ID: <ZQniwNEoYLo52HI7@ghost>
References: <20230915-optimize_checksum-v6-0-14a6cf61c618@rivosinc.com>
 <20230915-optimize_checksum-v6-3-14a6cf61c618@rivosinc.com>
 <0357e092c05043fba13eccad77ba799f@AcuMS.aculab.com>
 <ZQkOSf1b66lHzjaf@ghost>
 <0fe9694900c7492c96dce6b67710173f@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fe9694900c7492c96dce6b67710173f@AcuMS.aculab.com>
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 19, 2023 at 08:00:12AM +0000, David Laight wrote:
> ...
> > > So ending up with (something like):
> > > 	end = buff + length;
> > > 	...
> > > 	while (++ptr < end) {
> > > 		csum += data;
> > > 		carry += csum < data;
> > > 		data = ptr[-1];
> > > 	}
> > > (Although a do-while loop tends to generate better code
> > > and gcc will pretty much always make that transformation.)
> > >
> > > I think that is 4 instructions per word (load, add, cmp+set, add).
> > > In principle they could be completely pipelined and all
> > > execute (for different loop iterations) in the same clock.
> > > (But that is pretty unlikely to happen - even x86 isn't that good.)
> > > But taking two clocks is quite plausible.
> > > Plus 2 instructions per loop (inc, cmp+jmp).
> > > They might execute in parallel, but unrolling once
> > > may be required.
> > >
> > It looks like GCC actually ends up generating 7 total instructions:
> > ffffffff808d2acc:	97b6                	add	a5,a5,a3
> > ffffffff808d2ace:	00d7b533          	sltu	a0,a5,a3
> > ffffffff808d2ad2:	0721                	add	a4,a4,8
> > ffffffff808d2ad4:	86be                	mv	a3,a5
> > ffffffff808d2ad6:	962a                	add	a2,a2,a0
> > ffffffff808d2ad8:	ff873783          	ld	a5,-8(a4)
> > ffffffff808d2adc:	feb768e3          	bltu	a4,a1,ffffffff808d2acc <do_csum+0x34>
> > 
> > This mv instruction could be avoided if the registers were shuffled
> > around, but perhaps this way reduces some dependency chains.
> 
> gcc managed to do 'data += csum' so had add 'csum = data'.
> If you unroll once that might go away.
> It might then be 10 instructions for 16 bytes.
> Although you then need slightly larger alignment code.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
I messed with it a bit and couldn't get the mv to go away. I would expect
mv to be very cheap so it should be fine, and I would like to avoid adding
too much to the alignment code since it is already large, and I assume
that buff will be aligned more often than not.

Interestingly, the mv does not appear pre gcc 12, and does not appear on clang.

- Charlie

