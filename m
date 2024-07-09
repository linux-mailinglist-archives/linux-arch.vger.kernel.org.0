Return-Path: <linux-arch+bounces-5323-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB25392C6C0
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2024 01:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 664E028337F
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jul 2024 23:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2384218563A;
	Tue,  9 Jul 2024 23:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bxa2QnG8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAF01474BE;
	Tue,  9 Jul 2024 23:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720568873; cv=none; b=do5q4Miz6ExHbeKC6W73R/yPGAqu/EgMUmLILezp+vVT8L8cJX+ZE5LJ2JSjkuoxjnCoVGjZBY+3GvPf2imnJXi3+5V5zo2dE4WgzmXTtaCplIuZnV7SwTi28yz8Kob0ClnBnV7e8sKgCti/TRjioIStuOstYB+E/af9SyzXl9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720568873; c=relaxed/simple;
	bh=tIRE9KmLtc76s2mAlYfT2NzFMidl50saX5dJqrpwYP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1ZqGyYugMy6Sh/3Vo5ZIYKtfLEWXQV/WYYxiUGXYLQmxt7pQ3GkLGyFI6IMWtVnirkbg8wBAiKC7SDcK9UXvQq9i1E+spvElvf7rT1s0hZLuOOI3fmtdtoT2dOqtEqM4L4USdyNvxYIOYWAMWQWrSwHKhmcWz9qzzZbNJ4tHoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bxa2QnG8; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ee9505cd37so47094641fa.2;
        Tue, 09 Jul 2024 16:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720568869; x=1721173669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mq/A9aOkBamVBWV7aSMjKHp0LFUAAImFzSMnmFWp048=;
        b=Bxa2QnG8KFRMveHpvl45h1sAG+03olxIk1/ZHJz3r8VyXXpwgeO3ZnKWjt436dSBnP
         JQkL2XvT4idDsW/J3lTd9Sxn15mUSyOFjoVBJ+9mRzEsPo9Lo7jj+Y9iTNrSu3KOHliE
         14ozzfOjyvmN8OjeCygc7bWylOWHmAu0oO9qRlGaV+pYcHgcdh+B9nvM3OfI0vhW6iSN
         QNHCFYMzhNiSxc2bhjrXi/72q3onn5rNfpPjPwazl27doAiEZqIoTTjXGFJwsDlOTG2u
         qJtUA31LQoyGWElUmkbI3D/aeDOH6zvpzx5jHm9VEtNKGfKQrg8ElCiUJPsjvQGNat/u
         38Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720568869; x=1721173669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mq/A9aOkBamVBWV7aSMjKHp0LFUAAImFzSMnmFWp048=;
        b=f9/E62ayLqTZL4yxtaxIvbjQfy/d4t9c2EFOYyhnooEZSt88/PGXQ4Kc41DLrDyDAJ
         Ib2MEeDd2tNrUfgBZeC60ANzqySz36InguHoTaSX+VbgZOzupW/KB+RRvKxsVtJDrTdU
         KF/X4stZfYgs5iwWpfiTNRkmvHvXFpXDxs9Xee2cZ0KhupuCkagqloAF7VcnW6RVbZ7W
         ONB2MiegBKdxB6yoDjB2/7N8aCANzAmUh/k7oJiGtkG8Q45yxH8XmclL4137vVaqfqxl
         paf1javnw8Eix2IocfHflA4BykLDjOejFZ90XzSoLXF8c6Q40NfA3K0Q3lj4YJuWuZjl
         M1Wg==
X-Forwarded-Encrypted: i=1; AJvYcCXG7j9Cz/tHdc4iU/d5thMLK4p49npM6qageSXx77Mm+x5Qj7toqHsr90AiIerR+T+A/SWVYSnSeak5nslOp/7ARn2W2POua3X+HDxb1fRy0iJzUwyJMdqG1L7R21hOzkss/409L56TeYH5PjhPpYIFD5MILU0sDNAHVNhQWng3weKHWQ==
X-Gm-Message-State: AOJu0YyGHdLo8fe9IU1eADKOI3raBuTu9m8TSAu3ydmV6Eo8lP8S5m+D
	9adZBxcujlXuIyJdrScQleJXW060OTbwVnck1Pl6QdDkbQL/zzbg
X-Google-Smtp-Source: AGHT+IFR1lSNlGa657B6x4/YQYbJFtspl99U97GZRVKphke00G2h1klOiEvAgjx1eDOhCLqCcJHV1w==
X-Received: by 2002:a2e:3608:0:b0:2ec:4428:b6fd with SMTP id 38308e7fff4ca-2eeb30ba12dmr23925291fa.9.1720568868822;
        Tue, 09 Jul 2024 16:47:48 -0700 (PDT)
Received: from andrea ([84.242.162.60])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bd45a1b6sm1563341a12.60.2024.07.09.16.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 16:47:48 -0700 (PDT)
Date: Wed, 10 Jul 2024 01:47:43 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 01/10] riscv: Implement cmpxchg32/64() using Zacas
Message-ID: <Zo3MH8idihW4o+6Z@andrea>
References: <20240626130347.520750-1-alexghiti@rivosinc.com>
 <20240626130347.520750-2-alexghiti@rivosinc.com>
 <Zn1Hwpcamaz1YaEM@andrea>
 <4008aeca-352f-489e-ba07-7a11f5ab7ccb@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4008aeca-352f-489e-ba07-7a11f5ab7ccb@ghiti.fr>

> > Is this second IS_ENABLED(CONFIG_RISCV_ISA_ZACAS) check actually needed?
> > (just wondering - no real objection)
> 
> To me yes, otherwise a toolchain without zacas support would fail to
> assemble the amocas instruction.

To elaborate on my question:  Such a toolchain may be able to recognize
that the block of code following the zacas: label (and comprising the
amocas instruction) can't be reached/executed if the first IS_ENABLED()
evaluates to false (due to the goto end; statement), and consequently it
may compile out the entire block/instruction no matter the presence or
not of the second IS_ENABLE() check.  IOW, such a toolchain/compiler may
not actually have to assemble the amocas instruction under such config.
In fact, this is how the current gcc trunk (which doesn't support zacas)
seems to behave.  And this very same optimization/code removal seems to
be performed by clang when CONFIG_RISCV_ISA_ZACAS=n.  IAC, I'd agree it
is good to be explicit in the sources and keep both of these checks.


> > Why the semicolon?
> 
> That fixes a clang warning reported by Nathan here:
> https://lore.kernel.org/linux-riscv/20240528193110.GA2196855@thelio-3990X/

I see.  Thanks for the pointer.


> > This is because the compiler doesn't realize __ret is actually
> > initialized, right?  IAC, seems a bit unexpected to initialize
> > with (old) (which indicates SUCCESS of the CMPXCHG operation);
> > how about using (new) for the initialization of __ret instead?
> > would (new) still work for you?
> 
> But amocas rd register must contain the expected old value in order to
> actually work right?

Agreed.  Thanks for the clarification.

  Andrea

