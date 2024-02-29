Return-Path: <linux-arch+bounces-2777-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A300F86CA57
	for <lists+linux-arch@lfdr.de>; Thu, 29 Feb 2024 14:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC216B215B7
	for <lists+linux-arch@lfdr.de>; Thu, 29 Feb 2024 13:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E8C7E76A;
	Thu, 29 Feb 2024 13:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rYTHdjbe"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99097E76F
	for <linux-arch@vger.kernel.org>; Thu, 29 Feb 2024 13:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709213689; cv=none; b=LX2627pqL7hGZoe5I6fmF7YlsfWenVEkmE3WTHMqRaGCcNzamjDKyFnOKmDewjf6KbiVfMUyoYqsg9IdM5QazoqyXFV8WOYypHcEYRWGP7kM6fCcEq4bboqMrv0r7r2yBJPF+EH4n6mH3I9/z6hAhiIcL8onAcF6ghlQnRuuffo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709213689; c=relaxed/simple;
	bh=eTfLJyTcpdwpsuN8unpr2XZZEd0IJSDdAW3OCgpy0zE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJDCbwECg02LRYtKnGtw6awGZp2wi0AiqY9BeRBJWD7AqW9Cb6MDCFLyqKJM1LFILMuP8YEkCwN7OFbPs0hW7g79SWdtyL9r0fbQGziKst6J7LyzUn5aAUVgm1frK90Hp34iW9ITU57wtmNzatPvTwlMe7InQdegaX/eMg+WYOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rYTHdjbe; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-db3a09e96daso935699276.3
        for <linux-arch@vger.kernel.org>; Thu, 29 Feb 2024 05:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709213687; x=1709818487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTfLJyTcpdwpsuN8unpr2XZZEd0IJSDdAW3OCgpy0zE=;
        b=rYTHdjbepJHMdVjx9Imtk329wSoXnJZBxYtV726m28GV/V7gkGQXPfFJS2NlI0S+Z3
         pXj8RmkMOPs3Jb8OVqphW3Napgbwm1MIUNERMqYj4NC7ltvi8pWlz+H7gayZ6OINuFIs
         2OVx+oS+NV3eE2ZEX02/Rm9ABRCLur7+SmPKQ9hKv4p7d2wFX/CJXyoayu9c+vgIBTzW
         8wK5fPlhwVYHyYN2E86WCIwXywoAeodSrA5Fseo5fERoN2K9XEyGZOQw5KPl57WMELqa
         EfxraAKLsT0oNEysbw6hjhZJblor543ZwdklXGAAb1Tl4oYZgENGAgeCEVQK+lmfcI54
         1h2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709213687; x=1709818487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTfLJyTcpdwpsuN8unpr2XZZEd0IJSDdAW3OCgpy0zE=;
        b=FfgXl1mRJZfSMnjZfmjKf0ZdGSOJCBZrWMMh76ZNTaMUmjvrJzsKyKJ2c+cTqkvRR8
         rZRKG7ysUweynnMO4Ic0b1GvlcyX9YMbdFfFQqN7jKtkGjKru/nNeqWjc42NxI/Hi3bX
         NmjzcTApGxwKiz0ovhntXKShJwoDnSNDUQPKc4tkAs0oWTpb0q1m7Pzttpwod2maTz5M
         wJ94XTQDBehjudQlk9QSMgdgviZq2NxskoUKQdXIe0ab1JPUSu52akhNcO4/1ECS6t1/
         uPdl00KoNQEEgvEP7sGc/242bQQMBLoMUDkO6lcWEyz3qPK0veedN6cSMaskIJmYkvHc
         l3bQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdM8eysC8rBvTYTahZUyIkNv31iHeJaDfLPTFc244j//WT3gFw/ppMChRQvQCErclAt/27ecbaH6od4oooR8t63NY/0TaZeuzoig==
X-Gm-Message-State: AOJu0YyvGX0Hjnqd3cQ0XeMGts7SRb25o4tQ14ZrBM8WROubu8d6ZTcR
	bb0DTQNKk8SREEyCpqI5wc9TAAE8ONTSmXkI0KfNHWkVombuVpmbin/kd3aIcGn68uKcEZiWfER
	gX2igwdyFAUVlLImJ6VPaec8dQGrJhW5DJE17og==
X-Google-Smtp-Source: AGHT+IERWkObLg20g5CkQl+tvX5B3XTQSnYQFzXQbIMveAsaz3h9XahcBzBqENPTvOu/rO9KsYEoYLjXlY8xXBwHNlw=
X-Received: by 2002:a25:a347:0:b0:dcf:b5ba:1403 with SMTP id
 d65-20020a25a347000000b00dcfb5ba1403mr2165256ybi.6.1709213686916; Thu, 29 Feb
 2024 05:34:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131055159.2506-1-yan.y.zhao@intel.com> <20240131055740.2579-1-yan.y.zhao@intel.com>
In-Reply-To: <20240131055740.2579-1-yan.y.zhao@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 29 Feb 2024 14:34:35 +0100
Message-ID: <CACRpkdZ_XUmW__y=8R3aJkci+h-pHRh8-xH7ZmfRyQ=jjCbajw@mail.gmail.com>
Subject: Re: [PATCH 1/4] asm-generic/page.h: apply page shift to PFN instead
 of VA in pfn_to_virt
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: arnd@arndb.de, guoren@kernel.org, bcain@quicinc.com, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-openrisc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 7:27=E2=80=AFAM Yan Zhao <yan.y.zhao@intel.com> wro=
te:

> Apply the page shift to PFN to get physical address for final VA.
> The macro __va should take physical address instead of PFN as input.
>
> Fixes: 2d78057f0dd4 ("asm-generic/page.h: Make pfn accessors static inlin=
es")
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>

My bug, obviously. :(
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I thought this was already applied with the other fixes, but maybe it
was missed?

Yours,
Linus Walleij

