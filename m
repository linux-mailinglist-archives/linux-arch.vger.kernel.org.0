Return-Path: <linux-arch+bounces-4236-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 764078BDF87
	for <lists+linux-arch@lfdr.de>; Tue,  7 May 2024 12:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B035283A42
	for <lists+linux-arch@lfdr.de>; Tue,  7 May 2024 10:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44D714EC4B;
	Tue,  7 May 2024 10:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="S/Qq5gzu"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3099514E2F0
	for <linux-arch@vger.kernel.org>; Tue,  7 May 2024 10:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715077081; cv=none; b=NP7FqvwPJ6qYehd/FCTVcvWh8wnoeXkfUHt7/M5cL5sPG6beVeh4pyAKKjtsAxgcxXo2CLKJZDjcK1G0bZKU/5X5xeu/hU4+15JGj5MSJ9mLiK+4SejjvhzfyRkf0sjLyro360uu6aUJc26ULj8iHEtWA7Z9x3aD08+8yQZ41dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715077081; c=relaxed/simple;
	bh=dnCLNFqvQAKBlSVAP7aFTgdYYOKaC4MBtRCs2QJDt2U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=toBssSz+Sjukk4gIboPR4QuUSdCFUCCr6I1cA/qeceFDd3DiZGo0zVJbTyWz0RSxh5oJckF55CVN37z0Wm21JRbb4hvtm8jxS7cfsuNZ7qMAXoZsZKIUE/aEacU9GN46J+SN9gZZ37/rFFH7RK8PUVG0jRS5BlZdNlLb5TTk/9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=S/Qq5gzu; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a59c5c9c6aeso531423466b.2
        for <linux-arch@vger.kernel.org>; Tue, 07 May 2024 03:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1715077078; x=1715681878; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ac5rOAJKSZYYZ0IEteEWbW9YdJJoGTwzrFFHY2kYg9Q=;
        b=S/Qq5gzuKseZ7YCWKBf60ssxFOhGzkjH+zy5ZeYkFUiwmwPo+BabomtxTypUAInS0H
         sVfc5KiMrP0ywt0Te4trO8vTsS/IP3jGUzYVrKaKInXxYz45Oa9P2QW8VQ2JGPVt97NK
         2DBoJMKbOXOf8D2+CaiAaHd+YjojCBYo3AX/5K/cAV0hi6kCM/Jms8h9TmTKV5UMv+hd
         4Lq/GPQ/IG2Z1Y6YS/GD8OMAfhNyKbJR5OzfmBva2Gv4FeNdQRgoH/nmYbYQzJB6tHOH
         A8xtVaemSohmeJgbR0Hh7jK3JPhT7EPK1lkrTVUnXRPPlui6EKhlHKn1FBEPcio6RbmB
         A5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715077078; x=1715681878;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ac5rOAJKSZYYZ0IEteEWbW9YdJJoGTwzrFFHY2kYg9Q=;
        b=nPGbUZ/5EF+lmUG9C1OipiHfdm95L6/+MJVtnOLPJdGyYkg3ZwFKq+j4vHS9Iuibpr
         eX/sq6YAsJ41z0HjV0VvbdajyXa9ULNF4yf5pZJcH4rNAYk0QNOHh8cNYJPaOBFzO7Tl
         xTU+/PrOzwVfc9QIKlbvfnddMYDZCT7cuNZStReX+xOne8ds/ZCR+20gNtSnws2KwxDV
         ikiuT+EeMcf2k8WVO3mgKV+8blVFEcwX8NtdDWpy0/hxDFNXusMlTWvzOCZvYLCXpQN4
         qxVlR2ceokSN4ZlpLxlHrA0rb9Lve7V4YCcZbWF0tviBJJT4fmXblThb49+xhfoYssW5
         PfTA==
X-Gm-Message-State: AOJu0Yy4lfqARI80ik1XNmsNxK+AyHFv9UCDygmU6ydjd2dA1gPm0vUC
	lzmwIfcK/rd6dpvrql5qQYRFUvkxE+nUM9mNxMWbi5RztH1kiA1P9CvUC04aG90=
X-Google-Smtp-Source: AGHT+IHidoSypSQADr6hPkvXXj9CkAePoe6AE430g+iLHQAqPdhRx8cN0msxxdBv0xp6B/nlsbgYlg==
X-Received: by 2002:a17:907:7883:b0:a59:9e02:68fc with SMTP id ku3-20020a170907788300b00a599e0268fcmr7160173ejc.44.1715077078321;
        Tue, 07 May 2024 03:17:58 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:aa3:5c01:5c28:520f:55e:647b])
        by smtp.gmail.com with ESMTPSA id p16-20020a170906a01000b00a59c3cec28csm2976114ejy.10.2024.05.07.03.17.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2024 03:17:57 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH] bug: Improve comment
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <20240412135406.155947-2-thorsten.blum@toblux.com>
Date: Tue, 7 May 2024 12:17:46 +0200
Cc: linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <3E99B315-844D-4B5D-BD5B-CFC18EFE304D@toblux.com>
References: <20240412135406.155947-2-thorsten.blum@toblux.com>
To: Arnd Bergmann <arnd@arndb.de>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

On 12. Apr 2024, at 15:54, Thorsten Blum <thorsten.blum@toblux.com> wrote:
> 
> Add parentheses to WARN_ON_ONCE() for consistency.

Hi Arnd,

could you add this trivial patch to your tree?

Thanks,
Thorsten

