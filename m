Return-Path: <linux-arch+bounces-5170-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C6491AAFD
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jun 2024 17:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 003611C22A12
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jun 2024 15:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885B1198827;
	Thu, 27 Jun 2024 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBJB2U3D"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F287F179647;
	Thu, 27 Jun 2024 15:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501571; cv=none; b=s/r3rDcNdZ8EfhRXq87jiijT9m1Cls1IyKT70SfuqRWS+CEtjOH/xnW8f0SyLQYOjwUCi2AG/NGi/Ms+SiKDfQkESXu9MMcxS5+bWrib1Z6EahHrVxtlE1JkT7YXeNes1gdu0Mu2PxrYOPtl0qsm6AP7CX4Zb/X9cmnT8r7j/y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501571; c=relaxed/simple;
	bh=G+cBBek3drSnZL96hhiqkV5Q1WRRlmeLdd9tUoZQnXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEUUAft/L2mIqCuvKyBvWccyaZvvwMqQjAZ394ImVsLXe7sVBaTJjdM6iQkfdv1JEjt7XeIC4l9b0rDHztc1+tAHkPPGL8aSQiKH2kOuiqA9pxA19ltIcdPE969rUKd0jyrnb/KJLxTloj+RyEb855pLkhDG4uGB4PWrBCaFQPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBJB2U3D; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7241b2fe79so693462666b.1;
        Thu, 27 Jun 2024 08:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719501568; x=1720106368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=01JArmtEkWVzaNdRWksyS14M/NQjqvFDPF5Dykw99yM=;
        b=JBJB2U3Dj8xYSSgOLiqrgpR099s+1xzgt3tCe6r/SJPMEHCwypvbF7xVqgXEUNp86o
         hmC4Y5Iw5XS4u1wgK442NbcoOIoDwMAxjPWDLZhRKASSJ1LGGqojRSB3sEPuCdNt2X+n
         EZudZBz/G9oq1ImJvH/YkvwmhdZiMUETlDc0brCIrKZK/yBikCy2M/WzaxRY1ZlKqUJP
         kHOD2qF39qhlxrAv028Y/2nMki5VCZValaKIUwPwxkzaiLYMpv96WfB9NLk1rwIeAlhB
         h+n8lLDbETtxgRNA0oZ0S3LwYO83KDCe0K3EWSowJ05uJmX2hF6DQiVSkN8IKtzHYLFJ
         RN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719501568; x=1720106368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01JArmtEkWVzaNdRWksyS14M/NQjqvFDPF5Dykw99yM=;
        b=i0+0GUjOVjdjpCtzI/E3x9Ds4FZ8kbWgBGzYGr0tYPQk06acADUAsFR1gHgkXNcwu6
         UdBTqOWEXWiNcxcKcktd9Ras/4mu/91Q9J5QST4PonPPRF1LSqVkv2V+aw7rITeqrMyQ
         EZqaoZVoYxhbBC3nLJfh5HKRhpidNke5MDI9hCZXIJgiEuRo8e9DJHCFYCu7SwH+oqHx
         kTPVDsEV2Ji7/jwP0/N+4haHuA0hkW87XdWucYxaXUPtCDVOc+FSg74/ZFlMKJQ1rZSG
         GTO1drgLq2f9NagGi/S4mCp5MDe7KEpfHqMc7lXTfuxYkL4FkgMUhKCpSGqOgJYNz6NI
         PNoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiXUjm1/MTeUEX6Fl/+Aod9ZX0VoeQ6ah7nkGwjZ1x6qIIBiCJFRKJMF/cjcoJydh+aLLCabJMyrTZSEaXfm64vSxnZ5VjD1hfJf/HX93+AKvzbLgmDjSMqHVNaFntaQNQgvVssenRsa1tAYVqG5iDUhz+wf+WGZ7Na4omfet2Y7yoDA==
X-Gm-Message-State: AOJu0YwLrQli72+WH+wglLjYiDGdFT3dvLBYnMC9O+/jcpsEFJsKI5+y
	Ok+EmWug0bou3JFzqL9ZAfsKlc5D9RLchdwx4paivB3n6/qXckN5
X-Google-Smtp-Source: AGHT+IEAOJUUs4P5drce/yyI9yJaU8OuENn0jnZdouzCEJ6K8miFIV+B/HogjWpoIlxwTsUQCgDECA==
X-Received: by 2002:a17:907:d043:b0:a72:7bf4:694c with SMTP id a640c23a62f3a-a727bf469d6mr670678066b.16.1719501567509;
        Thu, 27 Jun 2024 08:19:27 -0700 (PDT)
Received: from andrea ([217.201.220.159])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a729d7c88cdsm68292766b.195.2024.06.27.08.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 08:19:27 -0700 (PDT)
Date: Thu, 27 Jun 2024 17:19:20 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
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
Subject: Re: [PATCH v2 10/10] riscv: Add qspinlock support based on Zabha
 extension
Message-ID: <Zn2C+NXNZ/sj0wI6@andrea>
References: <20240626130347.520750-1-alexghiti@rivosinc.com>
 <20240626130347.520750-11-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626130347.520750-11-alexghiti@rivosinc.com>

> This is largely based on Guo's work and Leonardo reviews at [1].

Guo, could/should this have your Co-developed-by:/Signed-off-by:?

(disclaimer: I haven't looked at the last three patches of this submission
with due calm and probably won't before ~mid-July...)


> Link: https://lore.kernel.org/linux-riscv/20231225125847.2778638-1-guoren@kernel.org/ [1]

There seems to be a distinct lack of experimental results, compared to the
previous/cited submission (and numbers are good to have!!  ;-)). Maybe Guo
/others can provide some? to confirm this is going in the right direction.

  Andrea

