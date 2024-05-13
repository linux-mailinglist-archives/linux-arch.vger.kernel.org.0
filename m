Return-Path: <linux-arch+bounces-4360-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A35D8C44DF
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 18:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D8BBB20FCF
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 16:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E908155335;
	Mon, 13 May 2024 16:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RTF7C4iV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA9B15532B
	for <linux-arch@vger.kernel.org>; Mon, 13 May 2024 16:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715616694; cv=none; b=LrI6zXDv3Ov/FDNsT9cnPHv4lH09FSRHW9Ts8/IE53pehJYvW5v4od0xTCJmsaadxADp3b8fDsY5qMqJOpjefmpJnexvacY5AxlPTn2E1juQpdTEZ1ngLnUpnbpQDhb827rZMNMweNElO+hCgXGCKY/etCSs8HGG4Bl3JY+ORq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715616694; c=relaxed/simple;
	bh=GI/6S7nq8gw8+qZwiqmtwyvLl6eJUsnvpSoLxQ6/lf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJnXPcHjF3NL1zc97gs7y4toyLUYBZnOAhLWSrLxYINyhDLO6Q01a70GDe1WPpj7HZQV04tkvSljY7xYbplrkatUrRuuzweFWX2JdGXvZL6UMVSAtePau30GxC5wEdMk7bh+ouD50R7mr+b7EfAE3J7JDyH5WYT50VbXsAS9shU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RTF7C4iV; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a5a5c930cf6so346994166b.0
        for <linux-arch@vger.kernel.org>; Mon, 13 May 2024 09:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715616691; x=1716221491; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LiMZcNte14dcc4wpme0lWntkeka6doEu5gChNQCkLOo=;
        b=RTF7C4iV++vAIG54OnFTKIQd88tDDiImBV73AqsUNIpHuyXW48ywpAcMPac32YB1cs
         umUzF/e3b+4gYxeh1XXDU88EjmwuCavZy4yfmFrGhZywCbnkh/QSuk8kG6PD8sLRW/kK
         ioRBcgTCOFKsCp4GsuoFFcUeO08ALehRbvIyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715616691; x=1716221491;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LiMZcNte14dcc4wpme0lWntkeka6doEu5gChNQCkLOo=;
        b=KBfMjunKb09KI3HNdDKGrADnGkdXoY3PNZ6qNxckutQB/2FK2cUJwMoG2Mt3BmQrkQ
         Ha95McZPv+VyTlgILFl65FFmdNKHVRpWBNrf59jce2sKmMOMtdCQd+Hv6B7/lVmjy/62
         N8eLEMr6fD1fRMjrwrE+hreIDERB2QbxKgoggJJpa2zyEmB1uZ1UPTzWpxalDS6p/udX
         cWcRO2mjEd5Pb/JRUVM5r8MGQlgxM799QuMnlr5SUawWdZ5HsLC2nN2BpcorfSRvvxFe
         TrBNCS7SvXiKpRsPyj8gdHSpsqxnzX83MSqxoNdWThXzg3sZtsgYMAHe4aK2QHDds7Sp
         BYhQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9zH3rMmQ7r96cs8xrpJ6HKN35bIRdt9TJz5JSTdLy+RxqBSAmovuaC7gihrVokK7UAxXzxziUu2IrPWTqLy+TcruHyeO6BD00Bg==
X-Gm-Message-State: AOJu0YwbVIuAaVtla0IAgvIxjhNZ3qKO0MXX32mgS6E0LmIMqGaoQ86Y
	w/KvUz1rDd2YCKPHm6diAZZgfroVnB18AGk0rqf27e+BRajHLdwG3rTLnsI14/h0Nwowrxq/KSt
	bL8g=
X-Google-Smtp-Source: AGHT+IGCeuRjElXr7F0F+VymTLWvQV8kJA8VOuPrAtJwu1xEex/Ok+dAg6GhY/mSzkMuHyOII6cEiw==
X-Received: by 2002:a17:906:dac3:b0:a59:b6a8:4d74 with SMTP id a640c23a62f3a-a5a2d3bebeemr810056566b.0.1715616690846;
        Mon, 13 May 2024 09:11:30 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d207sm609768066b.22.2024.05.13.09.11.30
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 09:11:30 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a59cc765c29so168151166b.3
        for <linux-arch@vger.kernel.org>; Mon, 13 May 2024 09:11:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXkhgGTe2wsJLJ93DXx5udG+COng6W3fvZV4VHpn2qOvNMrEvfUKKoF6I5ju0/MZ+pr/Fs7DrwWqoWOR+vyLNkSJzP6xG0+6mTeyw==
X-Received: by 2002:a17:906:4a92:b0:a59:affe:b9c with SMTP id
 a640c23a62f3a-a5a2d53b0b0mr657860666b.9.1715616689856; Mon, 13 May 2024
 09:11:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <71feb004-82ef-4c7b-9e21-0264607e4b20@app.fastmail.com>
In-Reply-To: <71feb004-82ef-4c7b-9e21-0264607e4b20@app.fastmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 13 May 2024 09:11:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh85pfJiHPPTZpknanYf6_JDEVDo=tmvtvy-XW+S7_Y8w@mail.gmail.com>
Message-ID: <CAHk-=wh85pfJiHPPTZpknanYf6_JDEVDo=tmvtvy-XW+S7_Y8w@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic cleanups for 6.10
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Thorsten Blum <thorsten.blum@toblux.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 May 2024 at 14:17, Arnd Bergmann <arnd@arndb.de> wrote:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic-6.10

Hmm. That tag doesn't exist. The top commit you mention doesn't exist
under any other name either, so there isn't even a matching branch.

                   Linus

