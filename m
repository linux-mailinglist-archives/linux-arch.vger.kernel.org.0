Return-Path: <linux-arch+bounces-7101-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B7A96EEF3
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 11:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3EC91C23BBD
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 09:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFA61C7B9C;
	Fri,  6 Sep 2024 09:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0IYQIoe"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDEE1C7B7B;
	Fri,  6 Sep 2024 09:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725614085; cv=none; b=pCQ1PSXc/MA4hsd52ob7nomPry1xbTjaEAxyYrttU/TFBWTXWxRQV72K5KoqSdXbwxV5zhY94J/+vCRzY4xADktwwOfS2XDcs4crI1Lc5z8EWN1jrLtAolz4hsr62o8KRYTOPw9BkY7d84WETS9GVh4Z5Xs0ApS31KeZTJmziE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725614085; c=relaxed/simple;
	bh=CMKQqQlBAwt7nyxZopr8LzhXpjpqLG+zrRS2vHgL2CU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F9xu9O3HXHVpEm/VQo6G0gzzUYBTndURmF85cSooadt4GbaAiK90dV9An9OwFOe7AMHqlZXYhVP+t4X1rjddwc9e7tAI4IQ9Ywb3hsY6QRA1OguHs3EzcWqQfpMXMbNMhpEVUngXnzrYh/m5GG27UzpbN0191vR1ikvaOOu2tFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0IYQIoe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50712C4AF0E;
	Fri,  6 Sep 2024 09:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725614085;
	bh=CMKQqQlBAwt7nyxZopr8LzhXpjpqLG+zrRS2vHgL2CU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=U0IYQIoeba7I86BlQCZUgY7cG6HJp2P8pN16E+8wtS4NA3f0A+QxJeNxfzeNHFQRM
	 37U8ndFZhrAIL5QhPbz7SVsS5n/Cob/pfNWiElVqKitYODD+w8EZ9qN2D3O1hXN4gK
	 BReAbislBv+hctHTQsXiB52hgiPOhjk+c8Z3eHPaI4iP3mEoJ+fd7rjqCshX2nqnqK
	 L3bRBzqKdvUGneVtGV0fYDl9qZOknFbiib428EGpUegM6MEAyR35NfQSVEh07hLw4W
	 YBmV84Au2oR3CGbwDaNWeyykhwf5vXAVAASu7T19lQ5frIbc7Bw1YDbAv76E/JfKLw
	 3czemgjWisuDQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5356bb5522bso2271773e87.1;
        Fri, 06 Sep 2024 02:14:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+SIEpXGE8yffkzpkHGLB1eXnu4Ln6LXoMtIffbrsreLo1PIKp0cgOwK4M6SsDCGyICLiJvtfS3E1jNA==@vger.kernel.org, AJvYcCU1XOMI+Mj+eVGDslwsENbtGD/Ity3WS/P4KL22x1L/1cvpd0dh0ejN0kLEnlB3rmlb9b99RBbflee+FQ==@vger.kernel.org, AJvYcCUgFvhJQN+4ncztOWonkr4Car65zyYBt76i5p+4Yi47caPvVqkjdPrPlYmOZu1tHhjF8BSxDKTeYZFzEw==@vger.kernel.org, AJvYcCVV2YkPhdSzWlLCDVN+vA8RbtpQoxXNavHDKXV6QMboKVbzgiQxnjOPSxo/AhBEC+6JkzGCcDR1nMzuHcX4@vger.kernel.org, AJvYcCVsbthfNM4SK52twxNzqSufYPNmFE5lmO+D3dZCY3Qow5t6iIdulB6fKlnyt876Fe+p62361MDUUAU=@vger.kernel.org, AJvYcCW3GNpdYq6UHgWnOjlAuD6uWP0fL53v1c2B+uv2M0oNEKWLVLNfwPwtqvGQv39C1kJ/9IWDxoJO8LoFlA==@vger.kernel.org, AJvYcCWAJutyRsaHRhl2dmuIZPWnPO55awRq5kvh6eEUZhyl8yIDNYpFn57sRkUlRNEgmXl9aHLHAAG+q+Iv2UEY@vger.kernel.org, AJvYcCWPI8JrD0+LrO4Mc+P2hN9WEUPkec3rGj4f8e7Z7MVqbRXUmtU1TcIxzHMs/QUJDp/+fhp5KWoXN1OmkvY+J3H1@vger.kernel.org, AJvYcCXf/NEcO5GpRmKUKrgTrjfMWLKqN5HqTX/JVyRdjs8vI+48nmT4FeAXTU6xLKrAuPCZn6cGcfJ8uxhdAg==@vger.kernel.org, AJvYcCXv8knzRFsA
 053GF/rHD6lWfK3EjULYuD/eWnk6kzWw8+j+OUxeunsFKVmjpXOsNNIHyvvhY3YFo7dPag==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBGf7WGPC7wzqZIK3qABhjLdw5NqP0dRhgW/rfNLmJALGGa4Y6
	X5slcTEHn3jMoZqPRQPyPVs2XRZEaFdRp6yilbnev01ZSDZ3RnQBbHWzxAC+3qjl2u+40kw59Ie
	4byxCURpbyBpXAs44UN1zZN/dsaA=
X-Google-Smtp-Source: AGHT+IG36wbIRnT1Ou+S3dPUzuz2yggKLEtxdYmatoEi0v4jKJk+IlFZ4GYCNU3aoE7cv9QcH4wQMa5emUdk1dRhZxo=
X-Received: by 2002:a05:6512:33cf:b0:52c:df6f:a66 with SMTP id
 2adb3069b0e04-53658815a6cmr1065929e87.58.1725614083466; Fri, 06 Sep 2024
 02:14:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905-patches-below_hint_mmap-v3-0-3cd5564efbbb@rivosinc.com>
 <20240905-patches-below_hint_mmap-v3-1-3cd5564efbbb@rivosinc.com> <9fc4746b-8e9d-4a75-b966-e0906187e6b7@app.fastmail.com>
In-Reply-To: <9fc4746b-8e9d-4a75-b966-e0906187e6b7@app.fastmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 6 Sep 2024 17:14:31 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTVX9CFM3oRZZP3hGExwVwA_=n1Lrq_0DQKWA+-ZbOekg@mail.gmail.com>
Message-ID: <CAJF2gTTVX9CFM3oRZZP3hGExwVwA_=n1Lrq_0DQKWA+-ZbOekg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 1/2] mm: Add personality flag to limit address to
 47 bits
To: Arnd Bergmann <arnd@arndb.de>
Cc: Charlie Jenkins <charlie@rivosinc.com>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S . Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, shuah <shuah@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	"Kirill A. Shutemov" <kirill@shutemov.name>, Chris Torek <chris.torek@gmail.com>, 
	Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-abi-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 3:18=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Sep 5, 2024, at 21:15, Charlie Jenkins wrote:
> > Create a personality flag ADDR_LIMIT_47BIT to support applications
> > that wish to transition from running in environments that support at
> > most 47-bit VAs to environments that support larger VAs. This
> > personality can be set to cause all allocations to be below the 47-bit
> > boundary. Using MAP_FIXED with mmap() will bypass this restriction.
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
>
> I think having an architecture-independent mechanism to limit the size
> of the 64-bit address space is useful in general, and we've discussed
> the same thing for arm64 in the past, though we have not actually
> reached an agreement on the ABI previously.
>
> > @@ -22,6 +22,7 @@ enum {
> >       WHOLE_SECONDS =3D         0x2000000,
> >       STICKY_TIMEOUTS =3D       0x4000000,
> >       ADDR_LIMIT_3GB =3D        0x8000000,
> > +     ADDR_LIMIT_47BIT =3D      0x10000000,
> > };
>
> I'm a bit worried about having this done specifically in the
> personality flag bits, as they are rather limited. We obviously
> don't want to add many more such flags when there could be
> a way to just set the default limit.
>
> It's also unclear to me how we want this flag to interact with
> the existing logic in arch_get_mmap_end(), which attempts to
> limit the default mapping to a 47-bit address space already.

To optimize RISC-V progress, I recommend:

Step 1: Approve the patch.
Step 2: Update Go and OpenJDK's RISC-V backend to utilize it.
Step 3: Wait approximately several iterations for Go & OpenJDK
Step 4: Remove the 47-bit constraint in arch_get_mmap_end()


>
> For some reason, it appears that the arch_get_mmap_end()
> logic on RISC-V defaults to the maximum address
> space for the 'addr=3D=3D0' case which is inconsistentn with
> the other architectures, so we should probably fix that
> part first, possibly moving more of that logic into a
> shared implementation.
>
>       Arnd
>


--=20
Best Regards
 Guo Ren

