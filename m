Return-Path: <linux-arch+bounces-4707-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD7E8FC6C4
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 10:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D85FB2454D
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 08:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC7D1946A7;
	Wed,  5 Jun 2024 08:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oBn6eZg8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1753B1946DD
	for <linux-arch@vger.kernel.org>; Wed,  5 Jun 2024 08:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717576702; cv=none; b=a2p7E1q6WGt9kuSYFyAw6D3Qf9p4ylMpAJOfjRHq66Z1fyUrEQdR+qK4O8wAwv7KtXBd71Q+cbmsNZTkIgr9h9VJArxXV0uXn1MPc1mW2HszLngFyhh0P/C1GuMqV18lnMWMewylxwc8ltJJIkB9gH6O5LATAd5yPgNVy9Ged4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717576702; c=relaxed/simple;
	bh=uB6WNlNFMa25Q/piLdGW+h2FWN9ed9vG8wJIaY0J6ME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eu+XhHd/HQQswglRfu3XsDuRw+hak/t5LFqjiHG4Vsoa/thnQWsYm6ukvy5x53WbrV1QlYeN99uY2otRExynWhbCebzq9yhoX55wBYgP4AikB/Q66sKJqxJuKQTXguVWSTRZA8HqCy1AfHlo33cJmrZ/Lc65Y+1gU0u0fpm2wzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oBn6eZg8; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eab0bc74caso6327491fa.0
        for <linux-arch@vger.kernel.org>; Wed, 05 Jun 2024 01:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717576699; x=1718181499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUWSW08nntJrf8CGVr9DXOkBBBauaj8YBTu+CpBRFmI=;
        b=oBn6eZg8h+bXTZ9U5iVDK1CssKZMfHRQI9hvl6uI7NPD1eG2WiwVZG2P/kWweG0KL6
         C8tjzdDO+9e14naPs7LAUqRgzk4MaijtHqNd7QaTfnqC/DJCfbZGBpeZ+U7FgIQybLIx
         VztlpS+XQnQtMX9FYn61CXh8UiWEHUXEyHU4GucVrguBvhHvoRGIwWWT0zbKlDrHaOz1
         B+6bOYHsAPegSnexiZ4qfuj9A3PVUZsWfMcxY5NG7Pv6pRM2k9Hu90evL4dXSMKxSWaD
         vsgtgQwGQWQytX86D9IETdw4tVduFGLsVmPp7pguXbMy//R0UcMspDCzkEUowqESPUY2
         iU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717576699; x=1718181499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BUWSW08nntJrf8CGVr9DXOkBBBauaj8YBTu+CpBRFmI=;
        b=NCVXSaH+aymQzHzDZB9a8Gk7mdd1CFccobJu+l+sSVV11LKBhDRKlgpK+34c8CPCRb
         JmbI8ePQOjFlQL5p1XaaPG1y+afdbcZlMYmMh8u01TLKwh9pnqj4g13BEUp6M0gFVPWv
         tiwlz+w+23jsqOk48Xsvt4rZOaFjI7QyEmP5hlBlFwfc4K4mwA0cysWkw+Ll/CXR70rB
         C8ynxpvP5UfJDDC6ZshCne6p+ev+iRqxc7Pis+sLkPIC8eC9VEncZkwCIO68Gge3crhA
         GU8bVlQyJ2weAxqEPpKmX5pzO9iOqhyUnDCES1N7RtzpScmekQslNhOPihtjXtQqUYnC
         qzxg==
X-Gm-Message-State: AOJu0YzO0sQSSu0P333Y8RUiOJiukyXYVznItHoK0O1TXhKG5M9LFbVM
	aYXZiABwBVvn43Tp4aUwDSNKo3Xk5RVmn5zmSDRD8nclB7y5KlWOVUfa/JaTF4HO9ZW7oUcYxvf
	T/549dN5puZs08ZLOCQTFZD9CEhR19LWznhc9PA==
X-Google-Smtp-Source: AGHT+IGa47xxFBOoSvrEt/XV5uGA0JUIqf0664xs+6A6Aka2gt3WvS4ie0V9Y07HNcqrVkyEu+v0Wuo/YC7l78WaDXA=
X-Received: by 2002:a05:651c:546:b0:2ea:7f46:174f with SMTP id
 38308e7fff4ca-2eac6470b9dmr7173571fa.20.1717576699220; Wed, 05 Jun 2024
 01:38:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1dee481f-d584-41d6-a5f1-d84375be5fe8@paulmck-laptop>
 <20240604170437.2362545-4-paulmck@kernel.org> <CACRpkdaYQWGsjtDPzbJS4C9Y9z8JGv=3ihQrVKvegJf8ujqSmA@mail.gmail.com>
 <2fbe86b7-70f0-46cd-b7b7-9d67e78d72f3@paulmck-laptop>
In-Reply-To: <2fbe86b7-70f0-46cd-b7b7-9d67e78d72f3@paulmck-laptop>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 5 Jun 2024 10:38:07 +0200
Message-ID: <CACRpkdYMiaMFmUoXyHdR9kLyAZma-24-m7cofztxd=n_Fr+GYQ@mail.gmail.com>
Subject: Re: [PATCH v3 cmpxchg 4/4] ARM: Emulate one-byte cmpxchg
To: paulmck@kernel.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, elver@google.com, akpm@linux-foundation.org, 
	tglx@linutronix.de, peterz@infradead.org, dianders@chromium.org, 
	pmladek@suse.com, torvalds@linux-foundation.org, arnd@arndb.de, 
	Mark Brown <broonie@kernel.org>, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	Nathan Chancellor <nathan@kernel.org>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	Andrew Davis <afd@ti.com>, Eric DeVolder <eric.devolder@oracle.com>, Rob Herring <robh@kernel.org>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 11:14=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:

> Thank you for looking this over!  Does the following patch (to be merged
> into the original) capture it properly?

Yup, also fix the commit message to be =3D=3D CPU_V6,
with that:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

