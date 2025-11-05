Return-Path: <linux-arch+bounces-14527-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC27C37294
	for <lists+linux-arch@lfdr.de>; Wed, 05 Nov 2025 18:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBEED188E64E
	for <lists+linux-arch@lfdr.de>; Wed,  5 Nov 2025 17:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F67339B47;
	Wed,  5 Nov 2025 17:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J40xNsLy"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27155336EEC
	for <linux-arch@vger.kernel.org>; Wed,  5 Nov 2025 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762364685; cv=none; b=QwQleBRaJVubM+d2CX2QDnIuF4Is3sgKkBl2T1CzcfuokOLG+0CbYwPWTOf57ZK3g75tNH0P/mjC/3K7zZ/b9/JcxTCwZglA/2daAMBxSGZm3ZwX6MHDgvmRRLSS2JtfU0GO3DKGcFFJiwbe5PD8GVXz7x1bohU/BaWmM+AcEnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762364685; c=relaxed/simple;
	bh=HUkuOvaJBgzglKmoQ0+qkvFukOe5dDQ3E3jps5qH8yg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZgIQwYAobLC1C8fuBQcwrSa49SsQvokibKPRj7ESD5I/FJAQxfZBZTexMnicR/cdXFof9n6MHSbthfbiyacfqIWAnXssOiFYCHfLnGRiaO0/PNtmXUQc76i5pgl5Jj4z46FfCgvci1TbdrU26L03FKKAVJDDKqT3RbUb3MA8MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J40xNsLy; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-58b027beea6so20e87.1
        for <linux-arch@vger.kernel.org>; Wed, 05 Nov 2025 09:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762364681; x=1762969481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUkuOvaJBgzglKmoQ0+qkvFukOe5dDQ3E3jps5qH8yg=;
        b=J40xNsLy/P3FH9ngX86nNzMKjkxfEccbIIBTI/ybiGLyBW/jbl4CuEQp0x2CEK7Anh
         3uaBzM2wz+AgVij7CWDHh4YOyKQj02OPu4ge/KnsIJPWcnoTxMjei28fxOFOVrPxjWvd
         1tsO0kv+ctxdr6SunZ/lhvTbcURPGC788zVeRY4lQsSuYXHJ9iUN6opOL5ICAYUO/u0/
         1drGwyuHnmJ3a9TiajQU/83cLDH1sNIfLkvKbDD9p1RNkj+GzEetgot9O2J6sntLO1Qw
         FmC6b/idfm9ycZYIVoxDBi6DuCBOaSEYienFsiRgDFUNAS/7FgzWc/eO5VyazcBTXkFL
         5yyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762364681; x=1762969481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HUkuOvaJBgzglKmoQ0+qkvFukOe5dDQ3E3jps5qH8yg=;
        b=PYPprQWsQctCpwjLzMS/ZHGR0QA1jbipH/+gdL6xUenTL0N7fkj2UTvDIFAou/iTsu
         XG4pSrpTnnXWuHaF5m4wIMHCHFjDREMNbVGXCEsEz/uKrJMelicIT8qkYWqXJ9x7Pk/2
         hpGmOGibo6Dp7xrTHlyCLpteaqiT8oNqHy/7SJCzK+j3tshKq3lfwTdOls4E3FV31aul
         MXnBkMPFShlyR8U/W4mdSZd3dy2jEIBBSKho3sXrWG5T8E2osmmARpqFcSV3zuYLI0iV
         Po+CBanCYkDydlvLOSdMim5Fl7ii4npGMNDA/+ee9o3VhWXaEIKpSNPtFqQX6nPHvAzQ
         00Aw==
X-Forwarded-Encrypted: i=1; AJvYcCU+3EBp1IWhsEZSr3k6/EWU9EIGBpPfG6xxU6RjsoZX0NqDYddqeo95NS9xqYsSNAyDcA3G/oyZJZEB@vger.kernel.org
X-Gm-Message-State: AOJu0YzbOI/MxzWYJ8EBgUWw1mpCL04RAgQ0HiADztWxHy/gSHEf6NrA
	XTLjfmZ62lsnniYx1nwPFkNqxacbidqEOTrhQO/K5zF8jDqpArCnp7dlEYaTH1cU+YzhrsDcQaX
	fGaB9NCrqC6AR8DWbSndZMOFXCYPH60W1tiheItbA
X-Gm-Gg: ASbGnctoynYy9J6DRlfUwNKtQyzpG6reejsrNDkaU+gkPDzPI6sfv3btvNQIDm0QY/U
	P01WUcUE+3XdUmFBZcgRclsPfTizMLSjDKvz9R1uAEkI7O3GgfU2NB25hXkY17KH260cfqYSkZ5
	FicgQ7MALD/qCuZ0Q3vXY9Jw1X86OvqnoTY7ICCScVQOM2TucG0DSeBH2BTPgZKwnAg2l1gmSma
	t00wnr29IBzJoVrbQS5DKkoyHP2TxmnJP6UUQAC+f3zh6qcWnx08rNmiDLAWOuZ1j2Vbep2MfEs
	LIG2EYan16QvkHI=
X-Google-Smtp-Source: AGHT+IH/OofWVZO6t+ABXcpC0vTR/s1RGUpbRd9qbTsriVnGknn3XRKBHSzmxdu2/OyTuJYhBxIZQv2+pBEj17RuTlQ=
X-Received: by 2002:a05:6512:5ce:b0:594:2644:95c6 with SMTP id
 2adb3069b0e04-5943fd37dd8mr299460e87.7.1762364680964; Wed, 05 Nov 2025
 09:44:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-0-ea98cf4d40b3@meta.com>
 <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-5-ea98cf4d40b3@meta.com>
 <aQuKi535hyWMLBX4@mini-arch>
In-Reply-To: <aQuKi535hyWMLBX4@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 5 Nov 2025 09:44:28 -0800
X-Gm-Features: AWmQ_bmalEOFVEMViz4jCYnQSNwi-DTRPOf8GHyJIDjQOr0wbo_hnqMUoM5NhB8
Message-ID: <CAHS8izNv89OicB7Nv5s-JbZ8nnMEE5R0-B54UiVQPXOQBx9PbQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 5/6] net: devmem: document SO_DEVMEM_AUTORELEASE
 socket option
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Stanislav Fomichev <sdf@fomichev.me>, Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 9:34=E2=80=AFAM Stanislav Fomichev <stfomichev@gmail=
.com> wrote:
>
> On 11/04, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> >
>
> [..]
>
> > +Autorelease Control
> > +~~~~~~~~~~~~~~~~~~~
>
> Have you considered an option to have this flag on the dmabuf binding
> itself? This will let us keep everything in ynl and not add a new socket
> option. I think also semantically, this is a property of the binding
> and not the socket? (not sure what's gonna happen if we have
> autorelease=3Don and autorelease=3Doff sockets receiving to the same
> dmabuf)

I think this thread (and maybe other comments on that patch) is the
context that missed your inbox:

https://lore.kernel.org/netdev/aQIoxVO3oICd8U8Q@devvm11784.nha0.facebook.co=
m/

Let us know if you disagree.

--=20
Thanks,
Mina

