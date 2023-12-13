Return-Path: <linux-arch+bounces-726-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A62807A66
	for <lists+linux-arch@lfdr.de>; Wed,  6 Dec 2023 22:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C798282572
	for <lists+linux-arch@lfdr.de>; Wed,  6 Dec 2023 21:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABB67099A;
	Wed,  6 Dec 2023 21:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KfkCRa9f"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2507810CC
	for <linux-arch@vger.kernel.org>; Wed,  6 Dec 2023 13:27:28 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1d075392ff6so2092455ad.1
        for <linux-arch@vger.kernel.org>; Wed, 06 Dec 2023 13:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701898047; x=1702502847; darn=vger.kernel.org;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=mbZzH+s3JDxV/sloks5umdqEjeI9fKLBWt3znOcMhGI=;
        b=KfkCRa9fM4NEjcL7Gb6xjuKXyCWeOKdTkvxTnIU2vfyNQLIfT+bqLIf95FhcEs4ds8
         euAWcJSfqGg0++Cx3B1VK5K+aDVcjAENud+a3jBW8mQwIKhzC3pqP/6mlh6/ViYg6RNI
         TfoNWfLLnygj5WeFkf8OAdZkElskLMAG8ZIoOb+QDB2k80pgg1xWWs5JF+/jfpsS7ngj
         T9xzop2Sgq6RpYEmMhk/u/+uvYB96343esMMFdKGxQxW32dz70VcRHJWJM5tCZ3Ylbxx
         n4XG7YWO6HBNEU1x6DnB4NHSMOXJ0zXf7dNjvuVlNvXMcFVAMVY0Lp8qoxPUV4iGWHIq
         gceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701898047; x=1702502847;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbZzH+s3JDxV/sloks5umdqEjeI9fKLBWt3znOcMhGI=;
        b=QtZMwmvq9FUSVR9pXc8H4e/xB/PJtkQNKjJnqerfOHD4m1r0nfQWW2oAR16AT4/tJX
         nhmJgOkKUgGzR5IOJ8+nEmSFQ+hDURjs8Z8AhjGGGWVNRXFzP+69U9W8V1U8wnQMk6on
         PXFwMC5OkrPHWs9B7uokK7Oi4RDlvV8qpvnaZE8yrWvwR1pS3pwIMQAaS5OerHe8JkL1
         eCYiJkmh4GtCrgECzGzHxJvw8O28O4Pjhtor5ibC+7TzImtWE845AYiF1i4r6ZoJ0xT0
         FyFjhi1C3VhyGp4BJbYJ2xU+OyctmUYr5G3RoH3rY4mYDuuDJb987B3ZyCUyZQNIX5Fa
         sk6Q==
X-Gm-Message-State: AOJu0YwcCjB/y5qovqAscKAlJujn4OFaRrlRovRa6IHij5zdoVJOhJhx
	bIKhA+iDBkPVX7nmMauYoZ+Iag==
X-Google-Smtp-Source: AGHT+IGLa8DInnGMjJcXZtON7bZ8pQ8xN1J6vJzQP1zj6zdeB3quK1/DibmWAlo2/mpEotTdJ4e23w==
X-Received: by 2002:a17:902:e80f:b0:1d0:6cfd:d3c4 with SMTP id u15-20020a170902e80f00b001d06cfdd3c4mr2193857plg.17.1701898047545;
        Wed, 06 Dec 2023 13:27:27 -0800 (PST)
Received: from localhost ([2804:14d:7e22:803e:f0e2:3ff1:8acc:a2d5])
        by smtp.gmail.com with ESMTPSA id jj12-20020a170903048c00b001cf6453b237sm259379plb.236.2023.12.06.13.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 13:27:27 -0800 (PST)
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
 <20231122-arm64-gcs-v7-22-201c483bd775@kernel.org>
User-agent: mu4e 1.10.8; emacs 29.1
From: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
 <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton
 <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, Suzuki K
 Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>, Oleg
 Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Kees
 Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>, "Rick P.
 Edgecombe" <rick.p.edgecombe@intel.com>, Deepak Gupta
 <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>, Szabolcs Nagy
 <Szabolcs.Nagy@arm.com>, "H.J. Lu" <hjl.tools@gmail.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Florian Weimer <fweimer@redhat.com>, Christian
 Brauner <brauner@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v7 22/39] arm64/gcs: Implement shadow stack prctl()
 interface
In-reply-to: <20231122-arm64-gcs-v7-22-201c483bd775@kernel.org>
Date: Wed, 06 Dec 2023 18:27:25 -0300
Message-ID: <87edfzhvia.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Mark Brown <broonie@kernel.org> writes:

> Implement the architecture neutral prtctl() interface for setting the
> shadow stack status, this supports setting and reading the current GCS
> configuration for the current thread.
>
> Userspace can enable basic GCS functionality and additionally also
> support for GCS pushes and arbatrary GCS stores.  It is expected that

s/arbatrary/arbitrary/

> this prctl() will be called very early in application startup, for
> example by the dynamic linker, and not subsequently adjusted during
> normal operation.  Users should carefully note that after enabling GCS
> for a thread GCS will become active with no call stack so it is not
> normally possible to return from the function that invoked the prctl().

-- 
Thiago

