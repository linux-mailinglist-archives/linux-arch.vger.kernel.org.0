Return-Path: <linux-arch+bounces-5272-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE40927C54
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 19:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C80321F24676
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 17:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A8E4C62A;
	Thu,  4 Jul 2024 17:33:25 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F6C4964C;
	Thu,  4 Jul 2024 17:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720114404; cv=none; b=WROlHPPqlWM8jg/84GYHtd4hLtABLGA9enMaTzPI9xxdJKmFOVRY1XioLE+I40K064neCDBslTpzHgSnzWnN3kZa8G6ewKfCcWE51ps9n7Cx0aK7o7zphfKZkIPi9bbfwBkwCa2OySwnNiKNG47thPnuGSzCifd/NMarlYWJLsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720114404; c=relaxed/simple;
	bh=xs6JzRjCQXbfSMshDcpOesOxGunDcEhzbocdxzU2ZCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L6z02huBMexETcgY+v+6UYD4SjS0IhYyFqohaqMgMA2btkGI+vgTiRw0oMQpHmMh4v6DsljwpFnrtWOkeVlp1TcpTzAsXyOZUjZiUWOSlz59gk937pyZ+Aq5xV19kepItBVlaQYtcuOXQx6VcnnO5iN5hoNrm6zA2xTKyqZHTTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id AB89120008;
	Thu,  4 Jul 2024 17:33:18 +0000 (UTC)
Message-ID: <98df164e-62d2-4592-a777-2a8182583c1b@ghiti.fr>
Date: Thu, 4 Jul 2024 19:33:18 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] riscv: Add qspinlock support based on Zabha
 extension
Content-Language: en-US
To: Andrea Parri <parri.andrea@gmail.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Nathan Chancellor <nathan@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
References: <20240626130347.520750-1-alexghiti@rivosinc.com>
 <20240626130347.520750-11-alexghiti@rivosinc.com> <Zn2C+NXNZ/sj0wI6@andrea>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <Zn2C+NXNZ/sj0wI6@andrea>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr


On 27/06/2024 17:19, Andrea Parri wrote:
>> This is largely based on Guo's work and Leonardo reviews at [1].
> Guo, could/should this have your Co-developed-by:/Signed-off-by:?


Indeed, I'll add a SoB from Guo.


>
> (disclaimer: I haven't looked at the last three patches of this submission
> with due calm and probably won't before ~mid-July...)
>
>
>> Link: https://lore.kernel.org/linux-riscv/20231225125847.2778638-1-guoren@kernel.org/ [1]
> There seems to be a distinct lack of experimental results, compared to the
> previous/cited submission (and numbers are good to have!!  ;-)). Maybe Guo
> /others can provide some? to confirm this is going in the right direction.
>
>    Andrea
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

