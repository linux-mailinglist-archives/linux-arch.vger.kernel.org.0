Return-Path: <linux-arch+bounces-3721-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5678A6857
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 12:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09E94282F75
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 10:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212AF127E04;
	Tue, 16 Apr 2024 10:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mj855mQD"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06BE1272BA;
	Tue, 16 Apr 2024 10:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713263277; cv=none; b=qanfGdlgEriu5vBv3jaxLmGzGqehuYKm1r+Kpy63IMv5VG4Oqc25bFBTxbpjHcbrilcpoINf1uRRsuDDaIHfooKdJMYPwhXPB3OkNEWJyGveDCdRiiXO6bfUj8XUffDcg0x2lCrgLYWDe5l+apU1PlZ7vsgyGK/e6zjMR2MSWRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713263277; c=relaxed/simple;
	bh=MLsdr7kD3zzTJKBErjYyRBFMSvmh3TMK8QeAykYBK+I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=q58BC4AlkQdUqwbJNAblpCud9U0MKroe96GsMlt0PUcbnp7e4PLtedw0XgMyLNCniFL6gs0TfIgU4V+0Ih/LUOeWSbQy1eXEY9sZfHjYRBmb3cjq9S+r73+yRykwuhE4fz5vFobyRs3QZmKMQqq7dCR7mI4fv0ByGucoEhPI49s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mj855mQD; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2a4df5d83c7so2737688a91.0;
        Tue, 16 Apr 2024 03:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713263275; x=1713868075; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/cIoa81DXO6MS6g+ZMtYagosHO4PwrAmNMYS0AM8V8c=;
        b=Mj855mQDhIpyr9qzSrgfhcQkGUnW6G7u1do9KM1mJ9TXReLQ8pnq9tJHVU/RFnPz6N
         n8MfOThWfabGg5lHUCV4OWiD1nvkPdQg1y55kUA/Z4RNNDEUDoVT9aX4Nr9Fns4lDSYL
         I3ITJpkYyQate+8v/BvX0Ap7TVrgh1TGle5tB3vyiSLAwaZnaEfprXIUSbsA61UH8V2d
         7aHmRUataD62M4jeGelBYPHtZzOBvnzYABi4gVEqiJcaJg5F+AlsEP0AuNBSKDyEmy3e
         bBmj+4RSU22IkNSowC1BOlVmMNoh5w65NQkQ7KEPGccyq+SyrKuyt9SSvgtQTy2jwMgV
         ASmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713263275; x=1713868075;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/cIoa81DXO6MS6g+ZMtYagosHO4PwrAmNMYS0AM8V8c=;
        b=IddMiZInCKHC0fL0alL33xJa5utZZmCxO2qV1k5TQR6EMZNyMgfYzn8L9Ti3QRTArM
         22Eee2mI3UnHcZsF8NI66Y8zg3L1qUP2OCauBtOQIfTXSM1fP78YnjoZmGudo4GFu2TW
         PcjsE1a9L/C6bTIDsoNy8SBH5oG4mp/vEdtA+Ecn+/cCSWydcltbLj+4cKJHsA8BNkST
         uWXQ7CrQi1KFm0L1iS6DlwfpDrnZx3hQ0SOOV9vFDHcmrGdW+JcjWEFpGdt/cYlH8ERf
         4pBCDy0zjYBeJ84/Es3734/o6rouhEfVqpompfq1+YJgamSjFDF7NLS8Xvmeg3+I0i/6
         /qlg==
X-Forwarded-Encrypted: i=1; AJvYcCXIl6EatsmSNFo6AcokWKdw2KENzfDG6btxrbTtJ/CFtQtZ+ci85tckwi1GZQi2SYdtJ7J5TpZ8oKTM+7LFJ29stVKwMyGCffGZUqvckVhtig/A0SGbvycp/sejEm1UkRlFNlft8HXWoQ==
X-Gm-Message-State: AOJu0YxFe0c8IzDQPwnSO8NF0zZrSLCFwne7G29nQzlbqYHBbMtK8t7j
	kukmc4klreU4KKPZu5OCdcz6xdsj7Bgg9MBc/k70+LIJwzeDOaoJkRmEXJfSvzAy9dhCY2E8uLE
	XcCUBEpEyi38RStQEAeDc6JtBHC0=
X-Google-Smtp-Source: AGHT+IEQCW1Umn5/jxfj5DsIuaZ2+exXuJmvDw88NBcTFIdc6HQg6SZiheR6MqEF6Ri8xe0SbEpGiX0n8YxTyu0/8v4=
X-Received: by 2002:a17:90a:8b05:b0:2a7:40ba:48bc with SMTP id
 y5-20020a17090a8b0500b002a740ba48bcmr10112056pjn.6.1713263275084; Tue, 16 Apr
 2024 03:27:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 16 Apr 2024 12:26:57 +0200
Message-ID: <CANiq72mQh3O9S4umbvrKBgMMorty48UMwS01U22FR0mRyd3cyQ@mail.gmail.com>
Subject: ./include/asm-generic/tlb.h:629:10: error: parameter 'ptep' set but
 not used
To: david@redhat.com, Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>
Cc: Andrew Morton <akpm@linux-foundation.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, loongarch@lists.linux.dev, 
	clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi David, Arnd, LoongArch,

In a linux-next defconfig LLVM=1 build today I got:

    ./include/asm-generic/tlb.h:629:10: error: parameter 'ptep' set
but not used [-Werror,-Wunused-but-set-parameter]
      629 |                 pte_t *ptep, unsigned int nr, unsigned long address)
          |                        ^

Indeed, in loongarch, `__tlb_remove_tlb_entry` does not do anything.
This seems the same that Arnd reported for arm64:

    https://lore.kernel.org/all/20240221154549.2026073-1-arnd@kernel.org/

So perhaps the loongarch's one should also be changed into an static inline?

I hope that helps!

Cheers,
Miguel

