Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076EF7A5796
	for <lists+linux-arch@lfdr.de>; Tue, 19 Sep 2023 04:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjISC63 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 Sep 2023 22:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjISC62 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Sep 2023 22:58:28 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B2010E
        for <linux-arch@vger.kernel.org>; Mon, 18 Sep 2023 19:58:22 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c44c7dbaf9so26848545ad.1
        for <linux-arch@vger.kernel.org>; Mon, 18 Sep 2023 19:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695092302; x=1695697102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ORUv82vqRYOMSTI3MAI/v8wlx+Ql9aKnbQUGVaGlaPk=;
        b=wS5pFz53WfNB6zNhEWhSmjVJ0B0Xa2hBhIUJf3cIGo/91N0TXEJD1Cfik73/QZo4Cm
         RGI2GX32YFTQl72rpLuSB9NfC6885oYvj89N8t5Ep1dXQgbi3jv5wA/PF8HyCtUb8feP
         A9d3Pm4C14Y1nJttPsSnx0IQvK5xqqxA7iUOgrP04WIXrubq68icdLPXfWcoQXVXZSW4
         O550msgyjxZFVobdG2NQdx68kGGUK0QYuTPqqCyr+IVxsnvL//dY4XbY7BPw/uKgJnA/
         aN9Pz7L99wjHost2RQW39mXcCW9T9zHek8jhcjELQH51PO7iSw4w9pOGjK0xhTesroJR
         muZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695092302; x=1695697102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORUv82vqRYOMSTI3MAI/v8wlx+Ql9aKnbQUGVaGlaPk=;
        b=H50mPPVnKi0mL2dIMgt2DXjagDgCQqfnrycDcdbBjpYJhifPFZG7/M6oHGd1rIKeNN
         hZ2gQTLbBmZVpdy6vP2eA74xahPaafNPMte1KCkPC2rm6TCD4o1ao2YHi8aZHPNibBvT
         zvhC9idq/RU/RwbYNx/rGLXKGF9jnM+YkLGBb96XMJQUs/7Z0j6MBKJXBsUczsjzBoQL
         Z5E3jlpocmx21QZj+PYQNJXTIo+KAHt8/8ptmJpBC4iihh+cfqx63/jwzblsBbQr7PY1
         cmbrAXv7GaaUog5rGf/UT8rtRaHNyKEoK6Z8RcKtqv1GSQg6c7CXdV4WNb6gT5ICaXIT
         e2Zw==
X-Gm-Message-State: AOJu0YwLSHKQnBu4GH8UdBmUcpdqulHvQqsAZSNBeBbhKfiGwEiJL15X
        LNnfpY6CNbVb6Kmu2/0mpKcqQQ==
X-Google-Smtp-Source: AGHT+IGvzqt10mRcT1dFlERUb3xtizvXDaC+nue1KjE5CKUtvggbx55iRB0WQs7JDN+aUlchqMqXaQ==
X-Received: by 2002:a17:902:eb46:b0:1c5:76b6:d94f with SMTP id i6-20020a170902eb4600b001c576b6d94fmr4069811pli.31.1695092302279;
        Mon, 18 Sep 2023 19:58:22 -0700 (PDT)
Received: from ghost ([50.168.177.76])
        by smtp.gmail.com with ESMTPSA id jj6-20020a170903048600b001b8c6662094sm5038719plb.188.2023.09.18.19.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 19:58:21 -0700 (PDT)
Date:   Mon, 18 Sep 2023 22:58:17 -0400
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
Message-ID: <ZQkOSf1b66lHzjaf@ghost>
References: <20230915-optimize_checksum-v6-0-14a6cf61c618@rivosinc.com>
 <20230915-optimize_checksum-v6-3-14a6cf61c618@rivosinc.com>
 <0357e092c05043fba13eccad77ba799f@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0357e092c05043fba13eccad77ba799f@AcuMS.aculab.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Sep 16, 2023 at 09:32:40AM +0000, David Laight wrote:
> From: Charlie Jenkins
> > Sent: 15 September 2023 18:01
> > 
> > Provide a 32 and 64 bit version of do_csum. When compiled for 32-bit
> > will load from the buffer in groups of 32 bits, and when compiled for
> > 64-bit will load in groups of 64 bits.
> > 
> ...
> > +	/*
> > +	 * Do 32-bit reads on RV32 and 64-bit reads otherwise. This should be
> > +	 * faster than doing 32-bit reads on architectures that support larger
> > +	 * reads.
> > +	 */
> > +	while (len > 0) {
> > +		csum += data;
> > +		csum += csum < data;
> > +		len -= sizeof(unsigned long);
> > +		ptr += 1;
> > +		data = *ptr;
> > +	}
> 
> I think you'd be better adding the 'carry' bits in a separate
> variable.
> It reduces the register dependency chain length in the loop.
> (Helps if the cpu can execute two instructions in one clock.)
> 
> The masked misaligned data values are max 24 bits
> (if 
> 
> You'll also almost certainly remove at least one instruction
> from the loop by comparing against the end address rather than
> changing 'len'.
> 
> So ending up with (something like):
> 	end = buff + length;
> 	...
> 	while (++ptr < end) {
> 		csum += data;
> 		carry += csum < data;
> 		data = ptr[-1];
> 	}
> (Although a do-while loop tends to generate better code
> and gcc will pretty much always make that transformation.)
> 
> I think that is 4 instructions per word (load, add, cmp+set, add).
> In principle they could be completely pipelined and all
> execute (for different loop iterations) in the same clock.
> (But that is pretty unlikely to happen - even x86 isn't that good.)
> But taking two clocks is quite plausible.
> Plus 2 instructions per loop (inc, cmp+jmp).
> They might execute in parallel, but unrolling once
> may be required.
> 
It looks like GCC actually ends up generating 7 total instructions:
ffffffff808d2acc:	97b6                	add	a5,a5,a3
ffffffff808d2ace:	00d7b533          	sltu	a0,a5,a3
ffffffff808d2ad2:	0721                	add	a4,a4,8
ffffffff808d2ad4:	86be                	mv	a3,a5
ffffffff808d2ad6:	962a                	add	a2,a2,a0
ffffffff808d2ad8:	ff873783          	ld	a5,-8(a4)
ffffffff808d2adc:	feb768e3          	bltu	a4,a1,ffffffff808d2acc <do_csum+0x34>

This mv instruction could be avoided if the registers were shuffled
around, but perhaps this way reduces some dependency chains.
> ...
> > +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
> > +	    riscv_has_extension_likely(RISCV_ISA_EXT_ZBB)) {
> ...
> > +		}
> > +end:
> > +		return csum >> 16;
> > +	}
> 
> Is it really worth doing all that to save (I think) 4 instructions?
> (shift, shift, or with rotate twice).
> There is much more to be gained by careful inspection
> of the loop (even leaving it in C).
> 

The main benefit was from using rev8 to replace swab32. However, now
that I am looking at the assembly in the kernel it is not outputting the
asm that matches what I have from an out of kernel test case, so rev8
might not be beneficial. I am going to have to look at this more to
figure out what is happening.

> > +
> > +#ifndef CONFIG_32BIT
> > +	csum += (csum >> 32) | (csum << 32);
> > +	csum >>= 32;
> > +#endif
> > +	csum = (unsigned int)csum + (((unsigned int)csum >> 16) | ((unsigned int)csum << 16));
> 
> Use ror64() and ror32().
> 
> 	David
> 

Good idea.

- Charlie

> > +	if (offset & 1)
> > +		return (unsigned short)swab32(csum);
> > +	return csum >> 16;
> > +}
> > 
> > --
> > 2.42.0
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
