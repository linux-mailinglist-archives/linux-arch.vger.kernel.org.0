Return-Path: <linux-arch+bounces-12837-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E578EB08DF6
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jul 2025 15:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 303EC7A8112
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jul 2025 13:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E68F2E49A6;
	Thu, 17 Jul 2025 13:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="iWfSQRtr"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972962D8DBD
	for <linux-arch@vger.kernel.org>; Thu, 17 Jul 2025 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752758280; cv=none; b=WhCfFHhqgCnYP2VtWIe+eK9s9Ry20aVoV6pRBYKSL2TBRnQHD4PNAi/REZmlFoV/j6V1dcD4pL7UZLr4Ubg+v1FzjN7MYBJS/pfg1/6heoL9o/fjsoRAmv6w2dhKo/K3Wjv6JaiKWxwyF2X0ax68QgstdyHAQ/dQqfir8IxfFJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752758280; c=relaxed/simple;
	bh=ZDviKLcvI9VrAI+wR/RQw9Ygk7b5+KAWd1c6p2r0hE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A98bmwDXBeGSSQQjxaXx7Vo5QycjXh+CVabbkyql0bF8XFQZwMxQ4cBYwcjJsw2t4mcdTbzCCFHOw6DcFYY9xzsYGmRqMhlH5hsH+5r3r5pvV9rcg07XchwIcod7wC+fRzvTNMwE7jokwoAl4V6USFKAXJAWoB0cXcxbRp5hIyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=iWfSQRtr; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4560add6cd2so7879275e9.0
        for <linux-arch@vger.kernel.org>; Thu, 17 Jul 2025 06:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1752758277; x=1753363077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDviKLcvI9VrAI+wR/RQw9Ygk7b5+KAWd1c6p2r0hE0=;
        b=iWfSQRtrFcaACc83FKbGj6jkzS/1AZDDKKIgEZwQ4n9Msae8ZYHbRoHBM9pQ/uQZB7
         /L2xlWb/O+RLCsWnbnSLb4qAIiLcS6nziyihSqSWmQKraUSR1xVm3ZNVfOLd/tiL8bl1
         zEyKN3nNsHktQnpJUOtN/7/XSqOeN1TeQIgbaHbcII3uiYL9CFyLI7e8I9k8AsxJgy70
         gi2jJSiE2ouXIQVyWt3vpfbl7rKQslmVLaGwDICMzHXn/Ov/jop90Xk9rmLftMgTbsmU
         V6sIGCRvRTfov6YlQf61QSYTGev5BbVMN6jyuqKeiZYfpPvh+FoqI9CgoNkS1HH7Xyli
         QCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752758277; x=1753363077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDviKLcvI9VrAI+wR/RQw9Ygk7b5+KAWd1c6p2r0hE0=;
        b=Sx/+4Pf8OHL8+qoHudQfcF/KIKkEQD6MLhCz1VlTVeLLyQZ68yqrCwS7S4OMHBYhuO
         KiyWuHeAoxDVHMlk0a/31k+8o1l6xZw/a/HlMSur/xf5I8SuAtPsYnw6sNvVDycpPwiN
         18a2HVXmmW+YNWyWnvtZV8RYGPidR443RmnHSKJasFX4tDhdDdz6EaNnyI1jas9FRTKU
         HfORFujBUyL4BCDTH2oXrZr3WSfs1Tx/WP4DCG8ivlVF8lU0B0ZRSH6eatDuOfREW1UG
         SbDNAEqmxTF+FTKVETsd9cPhbzy28r6RJI5Dw0Pyav8PphMK68Fbwpqlzg3BTfi9vBxp
         NIKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVwqFQEaN5qnhCxfjLCLhrY2OgXtji/i6u4JvG/F2bOO+V9WY7MR8CvPv59c3CnxwacZvaQHoI+Rcv@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2eK7Ik/A1b18Uu7Vbb44JJLdwxAnlQcuCKvqT5s+vQPIxe48Z
	bVr+qONcnJxe26mCTsAGL5NjAufAOKdPW+tfCPq/Eyir/OUYlizJ7OG4mG1Wt/xU4SjUqe9SkmF
	b4B40CIs1BnQxrCzj7QFVMnHrBDZ4xNvLJsThMluCbUPj3jMiOGrZGe8=
X-Gm-Gg: ASbGncvRCqGAG/JWzW4apgXy9n3q0MxsdpkqoFVJRJPNEdjotpZt+8dVERT12axKKUa
	auAKBaDN3UkUuC1KwATRii+NnA96QXBdYoWdqPV2RoTfK72Fp0aNQ7FEHwfGM+dTUxDjlGOPl2H
	diZB7uGhWdW8nZXAy+hQJMEpZD1aYsqtlet8JLnUv7EikLetCe1b2qhnGKudoLWKweS3WWcWwzq
	qoPWw==
X-Google-Smtp-Source: AGHT+IHWUpImxyj/M1iYj87ohSochOBEwmwUERfKvdToAyTI2JfgPVjFu+KTHMnlrSfiuDb5dWth2zr65OoSOyIcwLg=
X-Received: by 2002:a05:600d:17:b0:456:15be:d113 with SMTP id
 5b1f17b1804b1-4563451f300mr28829025e9.1.1752758276810; Thu, 17 Jul 2025
 06:17:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520-vmlinux-mmap-v5-0-e8c941acc414@isovalent.com>
 <20250520-vmlinux-mmap-v5-1-e8c941acc414@isovalent.com> <g2gqhkunbu43awrofzqb4cs4sxkxg2i4eud6p4qziwrdh67q4g@mtw3d3aqfgmb>
In-Reply-To: <g2gqhkunbu43awrofzqb4cs4sxkxg2i4eud6p4qziwrdh67q4g@mtw3d3aqfgmb>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Thu, 17 Jul 2025 14:17:46 +0100
X-Gm-Features: Ac12FXzAj1uStiEkTmwdY3kJmq5UyFHyQ5GKtR_wcQY_1cDKPtpY4TzHkBJQvTY
Message-ID: <CAN+4W8hsK6FMBon0-J6mAYk1yVsamYL=cHqFkj3syepxiv16Ug@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/3] btf: allow mmap of vmlinux btf
To: Breno Leitao <leitao@debian.org>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Breno,

Thanks for reaching out.

On Thu, Jul 17, 2025 at 1:39=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:

> Should __pa_symbol() be used instead of virt_to_phys()?

I'm not really well versed with mm in general. Looking around a bit I
found some explanation in [1]. Your suggested fix does make sense to
me based on that.

Let me run the patch against bpf-ci and see what happens.

1: https://lore.kernel.org/all/90667b2b7f773308318261f96ebefd1a67133c4c.173=
2464395.git.lukas@wunner.de/

Lorenz

