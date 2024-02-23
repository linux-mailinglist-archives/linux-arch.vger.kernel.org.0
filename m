Return-Path: <linux-arch+bounces-2695-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B916486104B
	for <lists+linux-arch@lfdr.de>; Fri, 23 Feb 2024 12:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9F541C21447
	for <lists+linux-arch@lfdr.de>; Fri, 23 Feb 2024 11:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808156310A;
	Fri, 23 Feb 2024 11:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuFagqGZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C77E5C911;
	Fri, 23 Feb 2024 11:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708687583; cv=none; b=DFmwvEOIzqSrOaUSgGMJPfE+jMYPFJ3lOKKWUwxHAvQ2wPfa1CsWctgsBWRac8cyuIytoENgXKiUHljC7nFMP4N5pRRtpsnugq0mWq8PSWx84H5EASb2VWgejBxXoAmPF9li7bBIw2VV3EE95AoWw7R/PjTOu0LF47SJZdjh+tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708687583; c=relaxed/simple;
	bh=ji5uTzd+emC2HMjDnotwfaplzIY/lJhoKEGU/JoWfzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YxcUxSzlqcnnkuH+56tC9RIf+8AozNZ614qKKHkX9rFz5uGxFlTLFGknk/0m1r3GCU/mYvoqEuEIovs3G/BsoMscnQ9K3gjRrVmgXUz00p27zEV1zZ8KHAYheU9u6bdewTebom2J8ZXlalkLEg2S8uTstW8Do5aboVzLgAE8pvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuFagqGZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA34C43399;
	Fri, 23 Feb 2024 11:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708687582;
	bh=ji5uTzd+emC2HMjDnotwfaplzIY/lJhoKEGU/JoWfzQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UuFagqGZtViV3iPl3qBCXD+2UPA/O44aOk65OgbuW5jyv/U9QQr+sGZtFPzpfWLbQ
	 tREm1+Y7Aye8jyCKSid0Xy64AmhFYAjSrRggV2vnJuvz163mHXR68yq3HUttIWHq71
	 cPNj/b29DGzKAEDyYHcGxDMhAtW7Za62ZqAyOV9PDfvpMQzf6GIOCI4KDDzcJ0bK/Z
	 KRpmkIc4BIEPk2Wo4V7p5KFtpGnFFoszIBvlTRLbI8A6ezTxz+N6VG/9adQovsuNLm
	 EP45PK/9pU1MdIqwczRjlIXASPmhqzowcIgNxyZPawbso8e3V8VTt+27bBF4216AV+
	 OwIt85pim3m4A==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-563c0f13cabso329258a12.3;
        Fri, 23 Feb 2024 03:26:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWrbMQ1CZ14kWMu2HIphIQTPcTZOXbLodFm/BRakIwTpUQHvmG2qBdmD4tBlFFCLX2eXgJrjz8b01UcbPxiR3yj6jgIpdTdXvXZbcTsrPJx3L6nouD7NF72Y9miE/QG3Ogs2/STzajoLZBuGcAGp/So1s5eiNWHtRnrR6HZHhcp7OYlWV59IMguL4N7Jyy1n66xRYaEK0f5j4ebJ6oR1UvCmE4dWvrVzZ4FIDLQbpNfp8CgO+yGSypI7ycfCKF1seHJzs0=
X-Gm-Message-State: AOJu0YwjTV+nMFEUIipf1MvHt0YxcHpr7ZKYVdZm4ge9diEM8nGYIjY1
	iMdrBYjdS0gfvk3bVjjFPwEWVtSMz391h6eYXI7Z/0+fSRAS98jO7jt7ifHJZfj/fdCYxVlBRty
	rLlC8u6Fns1CYXuxHh8PNppRst3U=
X-Google-Smtp-Source: AGHT+IE9uvJvCn7L0PhyRqMkyMRsnG/MzuLImMvhZ8F8J7qYEpE68QRfN2+IQzVgaRNo6pzxYl7OuOd7GkbSaCQ8b9g=
X-Received: by 2002:aa7:d316:0:b0:565:85c8:2352 with SMTP id
 p22-20020aa7d316000000b0056585c82352mr191517edq.7.1708687581160; Fri, 23 Feb
 2024 03:26:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131055159.2506-1-yan.y.zhao@intel.com> <20240131055740.2579-1-yan.y.zhao@intel.com>
In-Reply-To: <20240131055740.2579-1-yan.y.zhao@intel.com>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 23 Feb 2024 19:26:09 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTEaTnUCJhyU-bw=em_fo9ZW6bK=eaahUVsHcXuwaM8rw@mail.gmail.com>
Message-ID: <CAJF2gTTEaTnUCJhyU-bw=em_fo9ZW6bK=eaahUVsHcXuwaM8rw@mail.gmail.com>
Subject: Re: [PATCH 1/4] asm-generic/page.h: apply page shift to PFN instead
 of VA in pfn_to_virt
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: arnd@arndb.de, linus.walleij@linaro.org, bcain@quicinc.com, 
	jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-openrisc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 2:27=E2=80=AFPM Yan Zhao <yan.y.zhao@intel.com> wro=
te:
>
> Apply the page shift to PFN to get physical address for final VA.
> The macro __va should take physical address instead of PFN as input.
>
> Fixes: 2d78057f0dd4 ("asm-generic/page.h: Make pfn accessors static inlin=
es")
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> ---
>  include/asm-generic/page.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/asm-generic/page.h b/include/asm-generic/page.h
> index 9773582fd96e..4f1265207b9a 100644
> --- a/include/asm-generic/page.h
> +++ b/include/asm-generic/page.h
> @@ -81,7 +81,7 @@ static inline unsigned long virt_to_pfn(const void *kad=
dr)
>  #define virt_to_pfn virt_to_pfn
>  static inline void *pfn_to_virt(unsigned long pfn)
>  {
> -       return __va(pfn) << PAGE_SHIFT;
> +       return __va(pfn << PAGE_SHIFT);
Oh, that's a terrible bug; Thx for fixing it.

Reviewed-by: Guo Ren <guoren@kernel.org>

>  }
>  #define pfn_to_virt pfn_to_virt
>
> --
> 2.17.1
>


--=20
Best Regards
 Guo Ren

