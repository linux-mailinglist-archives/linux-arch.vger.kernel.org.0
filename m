Return-Path: <linux-arch+bounces-5432-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0AB933622
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 06:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A107B22BF3
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 04:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59815BA53;
	Wed, 17 Jul 2024 04:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="B/GANxE8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D5CAD5A
	for <linux-arch@vger.kernel.org>; Wed, 17 Jul 2024 04:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721192297; cv=none; b=PwuPe+oib9bCh9Fc3lmQbdzlmikwb+GimhaOdp0siJiBlWZ20o+cYuwo5GgPq50GNuPth3/XwjcTJt2H7/WzPWgOAk7RS1UvcyJtpnK59eI7+fqPb3p5LUnBDr5/qwcXiif4JSPgZrVnEQoZiC+SvAZxXb0ZQoJarVzIiTfRefI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721192297; c=relaxed/simple;
	bh=vABRMnRmbUscNHZGwHRUTWrzrPZYmjEVucxlkyKGsgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Azbf0rdu5DEOAZpUSnhsdb4skk806a8G1eTnoVERPXBU5KJGaj7z3Uz7vqP4xB5o41LdXdq6Scl9rNRSh8cqteHpVHazTzVEV84kIfyrRcPBwyOZOzT9BH8QYbUYjBAIKUaBKP2yytT04Uf/Pp3Fvc6wIyzWfKORzgW+9YqClJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=B/GANxE8; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a77c4309fc8so762516266b.3
        for <linux-arch@vger.kernel.org>; Tue, 16 Jul 2024 21:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721192294; x=1721797094; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EAXDs4QhymT5qdSIqwghPBIT7eGCMQME0KsEWD+9hyo=;
        b=B/GANxE87DkLINfPSCNJjOwvUUQWqQzeT7l/vnsPtYjYEbBXHFE7X3kF05uFryl7Ol
         /HyHKqxhWbeZA3tqoyi5P1K0YAMIjb5WmaJVe1Kv+R2YU1QnWKnUIbNSSB9CZ1/QoWGu
         Tm2DohU4ACVb+8SOUvHCHO7/heWiuJuJPlwj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721192294; x=1721797094;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EAXDs4QhymT5qdSIqwghPBIT7eGCMQME0KsEWD+9hyo=;
        b=Y50fjoEhx4/1LwK3l5xumDOcJCodLHsz/cObYNr4Dly9kZS8wFJuk3oirsktwLJUbn
         zdqNhgzBPR4xjgDaoXghqkyaU7wXh0XpmoDc054zzdMAGUmR2N4Cm7734cnJ8LCSJCL0
         Us9pYDbfJ1nZiIcAR9j/nCOsPdunXCdLdfShKBc8vEAUYSip1+Z2EusqUELXeoSRV/fr
         1/Q08Vl2wYWPTCtgJFL/g66oCNXoE8yyNx9zXAzbNMwVxxBXWhLshhtBorYNJuNvmWbH
         XmgDdg6FeF2dhoZK85cVJN/1r0laEedqjgCcCGgMH+9XBeuf3YsA4bssq7Qxv88gkuKB
         +fwg==
X-Forwarded-Encrypted: i=1; AJvYcCXN/f2EgvQqO/YJsCNFhmrQa/HAkcFyTEQw6jt8HykVEp82bf+DKum26GGmpw5ayA+M5sIZkTo3brBP05iYx0WK3ZWg7MLvjj4uUw==
X-Gm-Message-State: AOJu0Yx8sslXJvfBSrqxQxefYGkZfktvwyYKhWRkSijDbrwh41uPAvnx
	5gk+pGNe9rRE3g+EfURdVraJY+QmxENVhG9dALYNcuL0YdhY0ZVCyDOcIqCJVI+IA87b59l2Auz
	zhDxHcw==
X-Google-Smtp-Source: AGHT+IHdaj9v/ut/hNzH7c0LEZ+XDDFlNu6NwfCbysbM4q737tsz3dorWYRusAtM5zPuiv6MiPKrrQ==
X-Received: by 2002:a17:906:d9c8:b0:a77:eb34:3b4b with SMTP id a640c23a62f3a-a7a011208f2mr28651466b.11.1721192293934;
        Tue, 16 Jul 2024 21:58:13 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7f1d1esm399172266b.130.2024.07.16.21.58.12
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 21:58:12 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5854ac817afso7715982a12.2
        for <linux-arch@vger.kernel.org>; Tue, 16 Jul 2024 21:58:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVJsHy1Ipl6kjHyEXdvI5Ug/JJ3x646h20dPp1+xzhGImCNPfjjSF2meXjtD4LggOosjZy01g60HGuih9LiO/DVtwaQEMSshkVp3g==
X-Received: by 2002:a05:6402:5244:b0:57d:4d7:4c06 with SMTP id
 4fb4d7f45d1cf-5a05b7ee599mr504374a12.13.1721192292251; Tue, 16 Jul 2024
 21:58:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a662962e-e650-4d99-bed2-aa45f0b2cf19@app.fastmail.com>
 <CAHk-=wibB7SvXnUftBgAt+4-3vEKRpvEgBeDEH=i=j2GvDitoA@mail.gmail.com> <d7d6854b-e10d-473f-90c8-5e67cc5d540a@app.fastmail.com>
In-Reply-To: <d7d6854b-e10d-473f-90c8-5e67cc5d540a@app.fastmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Jul 2024 21:57:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wir5og_Pd6MBSDFS+dL-bxoBix03QyGheySeeWPX82SDw@mail.gmail.com>
Message-ID: <CAHk-=wir5og_Pd6MBSDFS+dL-bxoBix03QyGheySeeWPX82SDw@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic updates for 6.11
To: Arnd Bergmann <arnd@arndb.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, 
	Linux-Arch <linux-arch@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, 
	"linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>, linux-snps-arc@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 21:44, Arnd Bergmann <arnd@arndb.de> wrote:
>
> I don't see those either (this is an x86 defconfig example):

Note, it really might be just 'allmodconfig'. We've had things that
depend on config entries in the past, eg the whole
CONFIG_HEADERS_INSTALL etc could affect things.

And yes, I build everything in the source tree, so $(obj) is $(src). I
find the whole "separate object tree" model incomprehensible, and
think it's a result of people using CVS or something like that where
having multiple source trees is hard.

              Linus

