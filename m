Return-Path: <linux-arch+bounces-9425-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 845509F6564
	for <lists+linux-arch@lfdr.de>; Wed, 18 Dec 2024 12:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A54A18855C0
	for <lists+linux-arch@lfdr.de>; Wed, 18 Dec 2024 11:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC1419F42C;
	Wed, 18 Dec 2024 11:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZdD5dzo"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD19819CC24;
	Wed, 18 Dec 2024 11:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734523082; cv=none; b=fDvSQxlxleRUN8M0zGeE5GodINO80LrpGEYmYBGnhpgsG9GbOGxj3Qo7TGr3w70dfMNKkGiksqAKIjZAp/E/68YgJkg1b4j0qV9PPYydcemVWijTBn7IxyCe4DXW1TSFgFPPwS3zJ4v5Mo2lTe60VmjeAF+Y6m2adbTF/UXKD00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734523082; c=relaxed/simple;
	bh=oDanH9KbcyqaAgrkfJgfC45F72HSRGgPBJUOe3njE2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/fBTJExOEeRWcohHqqTtg/KFM/qvQBvMCP+2+cg/eAlm7ccESwv2WVsmvz1x8gmLCds0M6O9H2tFjCLQ0mL2oE0z5UKn2XdbjAWLob6yTHXfHKv+PMHrxUzLhJ4Or0JbUaVFTKu66xR7i/tq7YNa3rtx1VF69VTfPDQ9dq4yA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZdD5dzo; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a7d7db4d89so18301755ab.1;
        Wed, 18 Dec 2024 03:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734523080; x=1735127880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDanH9KbcyqaAgrkfJgfC45F72HSRGgPBJUOe3njE2M=;
        b=aZdD5dzoKsp4l74jP/zOEEKWca3RRWi1ccYAWIjMC9+4pf4tKThgkO4Pua+8RYaA3c
         icoR8gTCSY0KAXXK7g5xRPAH/fiEG7MhEIBh8tF0MF/grY4aD6TykN096IM7VAeMh/h0
         wQonvnb85qM3NT8+aOtCnoPWoctqVz2CfERLHr3a4cZdNdPJshRGEWPNDdPw1bcgma9w
         mFplRaMt1688yscCalOu50+nLeIUt0f4bPUmKsiG9Y6rgbjRlZVFg9RijQtGkBhQ+PjN
         AfJQlUFjkxophLqHGT+HUGR0WlfjAMGD54peyQXMJhCxbcJnUYYEBjknrT0vARBoW4rv
         qQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734523080; x=1735127880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDanH9KbcyqaAgrkfJgfC45F72HSRGgPBJUOe3njE2M=;
        b=qEvotuc9nIUb9sM09Xia83Juv8GtteihtxAN+LFtZLul/TXPlGsGbeOrExC7KjCcGj
         Zanv62WTI6x9P7zBn4+Jrrqiii998bEhe+1SlSztnc1CDBqieVAzUdqvdXu+HHZ1tlRn
         Id2+gr/5MEvm2Cwk6mUa6F0QvwfWi8H30Vmb7U4rXImVV0QkRifT23wyjmbaIKVURfzH
         tjfw7A4wCbTR1lmQUtG2BqJhRTvMKXsPdycmUUf0ultcIcQdrIHT+9kvZQsrOOkfKfvg
         EHyTcmNuXuSDxF804G3g8bkQ8dfUECJvGTH/d4HdoiKePulRfsrq0KEDeWn/lOkAucbT
         GORg==
X-Forwarded-Encrypted: i=1; AJvYcCUuIB/lqbYWQaRHksfMAE4zzV8y8K13hvRNT/bvunJQilbpmn/poLwkhOE4/ae9Oe16aMX7el6qsg86OQ==@vger.kernel.org, AJvYcCVjR5WOuB6eUVEPyQ5Hm8mUu02GjUs1NnAicxCbkDz4r4BeTbiKJVna0l5JLCY2WsIJMLc3xUVBBy+NcQ==@vger.kernel.org, AJvYcCW5sJQBwl8oHKk11LMgUSHSjCR6EkgDCOxBhZ4BHqxWwnPp2EjZ3A956eqcIopM5yW2119EPAVdPAVDqG/SRBld@vger.kernel.org, AJvYcCWPgpPiGie1AROjORv2kfXvxGu0OQe5vuG2p28jnbbqEWnIIB4rnhbzrtO8FTcqGILDUttymNUmlY5uWM29@vger.kernel.org, AJvYcCWRmemiWENLHQQiCECQvIepDJGW7zuWVnDwYNtLQ6lioq4/o9ZUoxlBbKkaVsar5zuVQkoed2hIwpZ/Og==@vger.kernel.org, AJvYcCXv1T2SXyLdwq/dgH+H199j7rP4TvT3hQiPIA0iW3pvlcsY9NS1PldRtPId2r0QGPEmcBb/I5NON0QA@vger.kernel.org, AJvYcCXzlI0aigyxLCkgE/XXesHPK+XGHEcG5z+JYi6GztF7h3+7ukLtWX8GjZSNsdqX3XNbqS2u7WDrS2G8rg==@vger.kernel.org
X-Gm-Message-State: AOJu0YycX/t3HNg2icVnYeVQuTZIvOWkePGPh/WcNBb1OMlmSN3IrUcv
	ZbXvPUL2eJ0TaHsYJwfFzhC/SwMwDDVJye++TlkfUCLjRdbD9lxfDRQYc7TjChbH1UT+At+nMlz
	R6nAzwYfLtzbMW+53DS3bV1rNeTs=
X-Gm-Gg: ASbGnculHUIHafJDWNpbWTmd9B2SwdArswVdgRCIUJEa+B4HkDXXm9yyM8t9TdXtEbx
	aK6OW/u3W7UARieyTYsCbi+dSdhikBxM3szkMvbfFQIvjJlD88KanxNYRb2+rgwfOnO/luKc=
X-Google-Smtp-Source: AGHT+IE9XVHYAxxlYi/lIqkTbCEk29pY3s/JbrTHqng5uSXtp2yGtDmOz0gqvTFlowYDieODZLuKDePCSd4DCR7eu4U=
X-Received: by 2002:a05:6e02:1565:b0:3a7:8720:9deb with SMTP id
 e9e14a558f8ab-3bdc1b288c8mr17567595ab.11.1734523079863; Wed, 18 Dec 2024
 03:57:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213084457.45120-1-annaemesenyiri@gmail.com>
 <20241213084457.45120-5-annaemesenyiri@gmail.com> <20241216182001.557e2c19@kernel.org>
In-Reply-To: <20241216182001.557e2c19@kernel.org>
From: Anna Nyiri <annaemesenyiri@gmail.com>
Date: Wed, 18 Dec 2024 12:57:49 +0100
Message-ID: <CAKm6_RsVpJjA2uHMJQO=5X-GJthkNnHJS=qHbiM2wy0AdADRhg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 4/4] sock: Introduce SO_RCVPRIORITY socket option
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, fejes@inf.elte.hu, edumazet@google.com, 
	pabeni@redhat.com, willemb@google.com, idosch@idosch.org, horms@kernel.org, 
	dsahern@kernel.org, linux-can@vger.kernel.org, socketcan@hartkopp.net, 
	mkl@pengutronix.de, linux-kselftest@vger.kernel.org, shuah@kernel.org, 
	tsbogend@alpha.franken.de, kaiyuanz@google.com, 
	James.Bottomley@hansenpartnership.com, richard.henderson@linaro.org, 
	arnd@arndb.de, almasrymina@google.com, asml.silence@gmail.com, 
	linux-mips@vger.kernel.org, andreas@gaisler.com, mattst88@gmail.com, 
	kerneljasonxing@gmail.com, sparclinux@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, deller@gmx.de, 
	vadim.fedorenko@linux.dev, linux-parisc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> ezt =C3=ADrta (id=C5=91pont: 2024. dec. 17=
., K, 3:20):
>
> On Fri, 13 Dec 2024 09:44:57 +0100 Anna Emese Nyiri wrote:
> > Add new socket option, SO_RCVPRIORITY, to include SO_PRIORITY in the
> > ancillary data returned by recvmsg().
> > This is analogous to the existing support for SO_RCVMARK,
> > as implemented in commit <6fd1d51cfa253>
> > ("net: SO_RCVMARK socket option for SO_MARK with recvmsg()").
>
> Could you follow up with a test? The functionality is pretty
> straightforward but it'd nonetheless be good to exercise it,
> even if it's a trivial C program which sends a UDP packet to
> itself over loopback?

Sure, I will send the test after the Christmas holidays.

