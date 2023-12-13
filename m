Return-Path: <linux-arch+bounces-957-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5181810854
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 03:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 908F4282013
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 02:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565D823AD;
	Wed, 13 Dec 2023 02:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZcidFv8J"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B06A1
	for <linux-arch@vger.kernel.org>; Tue, 12 Dec 2023 18:45:09 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6cebcf8a48aso5181669b3a.3
        for <linux-arch@vger.kernel.org>; Tue, 12 Dec 2023 18:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702435509; x=1703040309; darn=vger.kernel.org;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=CJ7qwCmvq20mGgi3dRymJGPN14h9pbhwL4VM2txPZCM=;
        b=ZcidFv8JCRaEhFx285fX5LJKtnAW/6xdQ+f7UfXQ943HmZyW9UeCMTAYCaHECv8vLb
         URWXgHbvPOMeXQuHw0S2vjSjHuBlCXvquyzPVXx4sAqi1JBubDTEmBqHBx1KrJeEMFSr
         062t+bhgVI5fKT3UeJt5TWjN/EyiUIycC4uMBVg7+ZpGfANAqH9sq327mW42WX36tCBA
         EmOhUf9rvG1Eo7TCMc5XNLm9Olzb5gcmAmGaze1GIY+DTTPP25On2mTimeGQpBImvEr/
         eUYhQKfZ/0EQF0sRexHfXempTf+gySR6FEDkr6mkUt0DHZ4wXN6L7dp0zbLaL0qsZsT+
         vaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702435509; x=1703040309;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJ7qwCmvq20mGgi3dRymJGPN14h9pbhwL4VM2txPZCM=;
        b=kRXNTK1QtkHVUPidJAxs2B7vhV7mztJRfZItXnJUMI4WJ6X/JZrrENgXCuxIH1gThH
         G+WWuls2Rcqf/DSWKseIJuF0XkgBIb7kWnFKY93Ix+OqRAQIiQvfh1vU5sCfzseudTNc
         CnaLshsE7iuziXbZohy+objiY7D2BRQfdr0DDgLn16JoVOYft62oRXwQRIPXz3nde6L0
         R4O6yhDvUFuS4PwyDwwKYC0IpQoWYabMC36cWYKLR7N5cETxCeKgK0Mdshxq1tqS8DHi
         CXyd42taYBEF3mdwyCNKy17qN/2M7AqqZqxpV3Bdkhr3yKWGrTy9FnngKI6Lw197SZ90
         zgww==
X-Gm-Message-State: AOJu0YwvUNC24+H4gzlNitgQuIdxOHz1j8OFR1jzUFZAAg+neU+c8EF5
	i5sBAVz03OjzGBb7TKQocEQL0g==
X-Google-Smtp-Source: AGHT+IGi//6HE3KINOZpirefGAX+e3jIHwZFWzUp/AR1xA1scaFysKSWvBw9/QjFkCNOqGCFGdEidA==
X-Received: by 2002:a05:6a00:c81:b0:6cb:a2f4:8579 with SMTP id a1-20020a056a000c8100b006cba2f48579mr8585102pfv.15.1702435509333;
        Tue, 12 Dec 2023 18:45:09 -0800 (PST)
Received: from localhost ([2804:14d:7e39:8470:cddd:ffc9:f19e:a4dc])
        by smtp.gmail.com with ESMTPSA id y72-20020a62ce4b000000b006cb7bdbc3besm9528817pfg.17.2023.12.12.18.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 18:45:08 -0800 (PST)
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
 <20231122-arm64-gcs-v7-37-201c483bd775@kernel.org>
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
Subject: Re: [PATCH v7 37/39] kselftest/arm64: Add a GCS stress test
In-reply-to: <20231122-arm64-gcs-v7-37-201c483bd775@kernel.org>
Date: Tue, 12 Dec 2023 23:45:06 -0300
Message-ID: <87zfyex1l9.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


I'm going a bit out-of-order to report a build failure in a test:

Mark Brown <broonie@kernel.org> writes:

> +// Recurse x20 times
> +.macro recurse id

I get an assembler error here:

gcc -nostdlib gcs-stress-thread.S -o /home/thiago.bauermann/src/linux/tools/testing/selftests/arm64/gcs/gcs-stress-thread
gcs-stress-thread.S: Assembler messages:
gcs-stress-thread.S:236: Error: unexpected end of file in macro `recurse' definition
make[2]: *** [Makefile:24: /home/thiago.bauermann/src/linux/tools/testing/selftests/arm64/gcs/gcs-stress-thread] Error 1

This is with gas from Ubuntu 22.04, which ships binutils 2.38.

> +function recurse\id
> +	stp	x29, x30, [sp, #-16]!
> +	mov	x29, sp
> +
> +	cmp	x20, 0
> +	beq	1f
> +	sub	x20, x20, 1
> +	bl	recurse\id
> +
> +1:
> +	ldp	x29, x30, [sp], #16
> +
> +	// Do a syscall immediately prior to returning to try to provoke
> +	// scheduling and migration at a point where coherency issues
> +	// might trigger.
> +	mov	x8, #__NR_getpid
> +	svc	#0
> +
> +	ret
> +endfunction
> +.endmacro
> +
> +// Generate and use two copies so we're changing the GCS contents
> +recurse 1
> +recurse 2

-- 
Thiago

