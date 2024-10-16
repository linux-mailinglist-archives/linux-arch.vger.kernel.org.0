Return-Path: <linux-arch+bounces-8217-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D33CF9A00C2
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 07:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11FD71C20D58
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 05:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F7918A937;
	Wed, 16 Oct 2024 05:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4GPtg3b"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A075E4879B;
	Wed, 16 Oct 2024 05:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729056795; cv=none; b=lwwJxu28o2qHyflak52XiI0O3/8xVgWqXKE0YLkmWuAjHA8ufaXyR0I+vF3cOw2WtTkJejecxrUfsgzxKVD9gDH431smYPKapJHYu3+4AcgSWViiIO/Z2tD56MSVAb99hlDKDcf8543udfUuoEOtAGdDLQPueupGlf10DO8GtUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729056795; c=relaxed/simple;
	bh=hVPLU5owgqN9EfLSLj9fyqPKw/ZCOrmGrosiR7XtYsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZxFrw2ZPs+/A1OANxaFq5AAY0YjBo4nGAaDXscUVwAsg6+KCEPczBM5ywUuq6kwSTqIk6hSH73souLECviXcctDVvDBwhaOtNX+ZQfT0NgJqYEKpuWVMCPf6s3oOLhDwFfW5uhL4c/P3QXwxQvEOzCIMec8jBcdPAYnynbyfFB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4GPtg3b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1513CC4CEC5;
	Wed, 16 Oct 2024 05:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729056795;
	bh=hVPLU5owgqN9EfLSLj9fyqPKw/ZCOrmGrosiR7XtYsU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C4GPtg3bIqr5iwxK1sgHEFhkSpDz1mryBKiygdzVoo8GrCkE8b8/LwasbjSdQ8DMB
	 iVJmbAAOsA/nW9bGc0xunAAzJ8VVnn3aNUdECZbpphuiRmsis54kgvUTg51Jf4iCsA
	 w1iQ5lhnZAm5JVglvtj56URvQCoQb5ry8qNKLGGZd57XZIev7P3sCYujp8kqcrtVxn
	 v/QoRyWA05Ld9ybvhxve4HKxTLZc/4cPvtx5yeCVBVJUBxtiQjBzYM8W9JECgF3nF9
	 56o1oW+URmW/Jqzylx1gWFFLAGqeIhY05STRDjV6rV8Ux4JbSY/sCDKFmETYXy7EkV
	 4bP2SyO1R31uQ==
Message-ID: <c1afa8ac-5c6a-4966-975d-915887c8106d@kernel.org>
Date: Tue, 15 Oct 2024 22:33:14 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ARC: Use __force to suppress per-CPU cmpxchg complaints
To: paulmck@kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org
Cc: vgupta@kernel.org
References: <c88fafb4-47d9-49b6-aeb6-5a83c9778791@paulmck-laptop>
From: Vineet Gupta <vgupta@kernel.org>
Content-Language: en-US
In-Reply-To: <c88fafb4-47d9-49b6-aeb6-5a83c9778791@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/24 10:55, Paul E. McKenney wrote:
> Currently, the cast of the first argument to cmpxchg_emu_u8() drops the
> __percpu address-space designator, which results in sparse complaints
> when applying cmpxchg() to per-CPU variables in ARC.  Therefore, use
> __force to suppress these complaints, given that this does not pertain
> to cmpxchg() semantics, which are plently well-defined on variables in
> general, whether per-CPU or otherwise.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202409251336.ToC0TvWB-lkp@intel.com/
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Vineet Gupta <vgupta@kernel.org>
> Cc: <linux-snps-arc@lists.infradead.org>
>
> diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
> index 58045c8983404..76f43db0890fc 100644
> --- a/arch/arc/include/asm/cmpxchg.h
> +++ b/arch/arc/include/asm/cmpxchg.h
> @@ -48,7 +48,7 @@
>  									\
>  	switch(sizeof((_p_))) {						\
>  	case 1:								\
> -		_prev_ = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);	\
> +		_prev_ = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *__force)_p_, (uintptr_t)_o_, (uintptr_t)_n_);	\
>  		break;							\
>  	case 4:								\
>  		_prev_ = __cmpxchg(_p_, _o_, _n_);			\


Added to for-curr.

Thx,
-Vineet

