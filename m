Return-Path: <linux-arch+bounces-11217-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9D3A78855
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 08:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6041018892EE
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 06:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037F61EFFB8;
	Wed,  2 Apr 2025 06:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWG8sByZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AFA1519A6;
	Wed,  2 Apr 2025 06:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743576487; cv=none; b=L5tVEF/wsXN5IAzr0b3B0h/HIbzLi9Oc6QD76ojWyinn1/hlHNoBsjJyIcg1mOqS1wVByN2nOF70Dvlkw67VZMGCN3/7gLH4oRhR1XckGEFeg30Skqm5ourhNy1uuHOwylLFSX/QThtbKWYEhNcJWqW2w4ezmSTwtXKfK9M7DhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743576487; c=relaxed/simple;
	bh=iVNySqzI/ywgVujwNPF6s7qzEAhRY/BGq1Z1JGoxe+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MKcRkBGkDbjgucukd/ZY0FxLiaoOk2c5e6MQg9lAtZg2nYmOKjKRyPlhJHU6scjIteoiFN3PFHujxvMrIkdHVL6NThqm6USXh99PUIGpGxQAw9kMBlDtqEmFHASw8ryA2bKJYTf+aaPR7XCkIlUONs9KJVBwMZzOgJR3TQTRKkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWG8sByZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96124C4CEDD;
	Wed,  2 Apr 2025 06:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743576487;
	bh=iVNySqzI/ywgVujwNPF6s7qzEAhRY/BGq1Z1JGoxe+E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cWG8sByZ9t/Eo9M7i7c+lQhHMsp7vCQ11v0UFyioEKWCEKKDMyVc7uTKWphqwO8rq
	 KtwKHdrZrJEg2zq2d2PPAWfsSK10pd4XfkooOrVsx9XSkYm2/5/nkTBjv4x0AV/r9e
	 8bpPotwmRiNM28nk1I0wEkeLAOPyCiaCwtpINYtCDWyJf0p4bjUwYCLx57ZwmIlLd3
	 i1ax3un5Y9JXJTxlrp7euYnHVeXaPKA0rpTgey+Zz8JCGVM9OUtSr41sQJ5FbQclaJ
	 S3K3nt2h1Wme+Z6xg1tWO7Ij+aLrI+SUoBI4kU7scldG5GQ4u1NLXG6GF7xjeiow/S
	 2jqv1EtGAjT5g==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5499614d3d2so7174775e87.3;
        Tue, 01 Apr 2025 23:48:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUfyr8pK55148zJKgBOgQ2cmCjxSFCdYQnI4OHFnD8mCLpMpw2W14G3K1CwB3lYYmoY2iT+2x+CbbPC@vger.kernel.org, AJvYcCV69yVf1/bAhKiNmgiHTAAwgYVLli8dreBk1emX2nXGCLKQRlIRCR+fVkYKWGKGIUEmirxu/D6b8gmSOEMw@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcmyo+KWP4ncVszxRADGX7BXS30i6VIrOymt0yxCWYba259/PV
	JZMOw8G7XegcF1vUuYiFqCZ0UjY0tBkgZeUhZni1OnJF8DhvGNhq1G8g7SPlF3gEt/7924QfJFq
	BV8liA7Njdg+2qeES3hG3GLX9M1w=
X-Google-Smtp-Source: AGHT+IHxviuonsU0zEvEJ+Udb3/Dy+1c6pqnxL3k+SX3TxRyk/NjZhQgUEtXYtRfDvPjXFW/EDAEq7EGYqjTuuKc4zY=
X-Received: by 2002:a05:6512:2c99:b0:54b:117c:118c with SMTP id
 2adb3069b0e04-54b117c11f5mr3947880e87.57.1743576485964; Tue, 01 Apr 2025
 23:48:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401221600.24878-1-ebiggers@kernel.org>
In-Reply-To: <20250401221600.24878-1-ebiggers@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 2 Apr 2025 09:47:53 +0300
X-Gmail-Original-Message-ID: <CAMj1kXFQE5B=B=Ptj=8zxNU=Xiu+NdympxfSUcvYbHVyNsNGFw@mail.gmail.com>
X-Gm-Features: AQ5f1JoAivqiRF6ZW_-JWRUhAevLivGhDUBPRKvbGoRyBb3736u6IzcEZAjTes0
Message-ID: <CAMj1kXFQE5B=B=Ptj=8zxNU=Xiu+NdympxfSUcvYbHVyNsNGFw@mail.gmail.com>
Subject: Re: [PATCH 0/7] More CRC kconfig option cleanups
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Apr 2025 at 01:16, Eric Biggers <ebiggers@kernel.org> wrote:
>
> This series finishes cleaning up the CRC kconfig options by removing the
> remaining unnecessary prompts and an unnecessary 'default y', removing
> CONFIG_LIBCRC32C, and documenting all the options.
>
> I'm planning to take this series through the CRC tree.
>
> Eric Biggers (7):
>   lib/crc: remove unnecessary prompt for CONFIG_CRC32 and drop 'default
>     y'
>   lib/crc: remove unnecessary prompt for CONFIG_CRC_CCITT
>   lib/crc: remove unnecessary prompt for CONFIG_CRC16
>   lib/crc: remove unnecessary prompt for CONFIG_CRC_T10DIF
>   lib/crc: remove unnecessary prompt for CONFIG_CRC_ITU_T
>   lib/crc: document all the CRC library kconfig options
>   lib/crc: remove CONFIG_LIBCRC32C
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

