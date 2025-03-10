Return-Path: <linux-arch+bounces-10607-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58201A59522
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 13:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8583B16CB63
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 12:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080A1226D1E;
	Mon, 10 Mar 2025 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msrLu4Ch"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EFE35963;
	Mon, 10 Mar 2025 12:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741611136; cv=none; b=JcOFlgmbZLgqsTl+TgtxP8nbMUnMa8cKZDjk1Pn3QLMjknRboexbaPVymkHBLSGClvuMoqSYrQU75n7DGHV1Ln6kXnu+S5KoJZs0Rfb9qgPnlmdVNvPNMdOysLsMlLQYaBhDfTpBHurCb9K9P82stWHJsk4YJH6lTXobVxPzWnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741611136; c=relaxed/simple;
	bh=IsO2fJ6cq9pdq/WTSW+tPj6Eq0Tb3UI6bZpj045PKQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ult1Aiyo5nGZUKrnKllbYx8YmLssKgy45tazaEjx+nzq3MG2y0jiGSANdhgOg9qX2pBeKnN+CPVpkwVmmka6OBITqnzCweHHI8WVZDacY/e2tcaIcuF67yRXkU4WPNDWzR5FimbJWSi4TmiIF0zICy4VdJjlqd4s/k3hqJVvSTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msrLu4Ch; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so8024288a12.1;
        Mon, 10 Mar 2025 05:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741611133; x=1742215933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsO2fJ6cq9pdq/WTSW+tPj6Eq0Tb3UI6bZpj045PKQU=;
        b=msrLu4ChxyoKztjakYEnojnC5yZrTgsii/tyDeIc0VORTXfqMYL70VRcVVTuTczkmq
         OffEuyoaeupEoE4B0BpJxim/smXbKiR4PH7aw05Qg+44SRYKjlmArHNS6zBcMlKjAPxj
         m882qPlsBHnkZjGlN3V7U1UVpGI/Mf2KMRemGaOxaMcg2c3rogA+iB7dXG7GbTvh0/B6
         POs5XHsCuudWk5J8AalYZVUwK+KtN6H/voCYGx3Q7ygFRz5fc3Q9lcLcJN/L9jHvelGe
         HQxfdpgk85WzKBCi0EQAZrXN17r+J9/0e3txAkxKYv6Y4bQyjKLZPyHH1uRC2blvZBXc
         zuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741611133; x=1742215933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IsO2fJ6cq9pdq/WTSW+tPj6Eq0Tb3UI6bZpj045PKQU=;
        b=QLvLOM+ffVYy0M1p9USfjYAQ/+xLjA/osi+lKwVfZFJa9SRW1iGLSJyKxKh2uE591k
         ZJs7VlQB0iBt+ZtplCFAcpRQObY0oOO2BzifoCTX9VYWf5RGpNK2oIkvLMz5kJLmKx1x
         T3bU91/JsDnIcPcjKnIPUdMzbDTXMtbzUqnno6+xVfCY8bh7x9JzjMkqoa28mRpUWMp6
         pIObIymCvLNXPIxLtHENG2hWJrrQXXN5grkPbnjxeBVX0RApNVlhYIB+oNTaCLsdnNL9
         z7kIXHNxYOMVUSgHrWCS7nN4KuX89u0cQxUEcg7+svXxShCiHmTPvqbxiWhBtUDwBMy6
         arxA==
X-Forwarded-Encrypted: i=1; AJvYcCUhdoa2vvcv72ZBzYlwJhBpINK/U7qcQjGY1VbgJTr58j07qAl1c+cCaejfUz3gj9Va9ddPVDk1ckm7@vger.kernel.org, AJvYcCUm7Q0+cWr+0atAr85dox8GbVvhVL+FknzflVAWUGBZjJyE2SFGVQiAHPYmWTna2+E0K/+HtF2JmxmNfwR9@vger.kernel.org, AJvYcCV3tS/uiRP+Mj1yFgS78UYlsr4T3j7dafSsI3H/3jcIzm223+1rTvy7UwTcMu6t1IBXyTWzm7DYA49W+A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+MsP/hn/64wPW2CxxYELsRa0BGM+izjCoUXL4gBKA5oMJdFXr
	1Oelg7usCo+SLC8LqwXYx1dSEvU9XPNuXiOvt7IJQVFtktf+iuY7qGVzbLkwD+1Buw8wZPOoAgH
	1iS8+0UAHXlO/wm9boPTMpyryrEA=
X-Gm-Gg: ASbGncug9Rslgt11K+n0tINDTso5ocq0Ybm5EV7TQdQIALtCseoW390m9M6QOwz+UxZ
	HawB4G1u8/704OdJl3Atgx2f/miulVCS3ikar49/WEHR6wcXfhdPtt4IuRD6NBokamk0XaPc6hl
	CzJrHFkGSIiWkKUAwKIlCO5TJaNzL+FMJLDBt1pXVyqN3+
X-Google-Smtp-Source: AGHT+IF0bYWGe4Fmo22RSpPatdmw+87/zdDh6bOztJpjAX5OtLNHVpRiEKuqE2Y797OiBIf0Zkae239Ix1mhgUN6BD4=
X-Received: by 2002:a05:6402:3507:b0:5e5:b3cb:38aa with SMTP id
 4fb4d7f45d1cf-5e5e24dd558mr13645616a12.25.1741611133396; Mon, 10 Mar 2025
 05:52:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-5-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To: <1740611284-27506-5-git-send-email-nunodasneves@linux.microsoft.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Mon, 10 Mar 2025 20:51:36 +0800
X-Gm-Features: AQ5f1JoNaKQNf7RCTRzeqWK-w55-IhlYCYK3_qpuW5zNCfXinD-QYDINJtQnu-A
Message-ID: <CAMvTesCs3ieYDEnC1xd_U=XYvg2u_qE7FZRLp5OoWh1Co8p6+w@mail.gmail.com>
Subject: Re: [PATCH v5 04/10] hyperv: Introduce hv_recommend_using_aeoi()
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org, kys@microsoft.com, 
	haiyangz@microsoft.com, wei.liu@kernel.org, mhklinux@outlook.com, 
	decui@microsoft.com, catalin.marinas@arm.com, will@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, daniel.lezcano@linaro.org, 
	joro@8bytes.org, robin.murphy@arm.com, arnd@arndb.de, 
	jinankjain@linux.microsoft.com, muminulrussell@gmail.com, 
	skinsburskii@linux.microsoft.com, mrathor@linux.microsoft.com, 
	ssengar@linux.microsoft.com, apais@linux.microsoft.com, 
	Tianyu.Lan@microsoft.com, stanislav.kinsburskiy@gmail.com, 
	gregkh@linuxfoundation.org, vkuznets@redhat.com, prapal@linux.microsoft.com, 
	muislam@microsoft.com, anrayabh@linux.microsoft.com, rafael@kernel.org, 
	lenb@kernel.org, corbet@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 7:09=E2=80=AFAM Nuno Das Neves
<nunodasneves@linux.microsoft.com> wrote:
>
> Factor out the check for enabling auto eoi, to be reused in root
> partition code.
>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---

Reviewed-by: Tianyu Lan <tiala@microsoft.com>

--=20
Thanks
Tianyu Lan

