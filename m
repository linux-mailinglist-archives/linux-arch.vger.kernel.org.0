Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BF47DE4FD
	for <lists+linux-arch@lfdr.de>; Wed,  1 Nov 2023 18:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbjKARGe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Nov 2023 13:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjKARGd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Nov 2023 13:06:33 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A085A10F
        for <linux-arch@vger.kernel.org>; Wed,  1 Nov 2023 10:06:29 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cc53d0030fso491755ad.0
        for <linux-arch@vger.kernel.org>; Wed, 01 Nov 2023 10:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698858389; x=1699463189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ACtbDGuD6MnDLtRfrY8r3GOV1M4ngbjpcwXbhvL0euE=;
        b=P6RS5VG3dAppFpjc9hkAVqsv5Vjq9QigYbFnG5QcKvnEdihFo+HN4v6zbOjOF2zs/W
         oMKfqHMhO7CRDihmTS53TkMazuNTW8muMF5cnrnNUvQtJxObv5hO1qECfFlK0pg67Oxn
         D/qydX6aWGinxjJoRWqeVf8CDV6dQcMUu5wjzv+3/OjNLhBCBMBnGk3DAVupzySbgElC
         d5nz9DztbUCpt6mxCtlJfJ3bPmQ8fycHxGuu4Ih8q2eWiolXuJN1A9naXdDB442pmY0Z
         oeFjDC9Qn9WmC739SJSIGUzFZVpjwkZjPZJveeukJt3TLdECfSMU5GETODzFbCg5h7GQ
         C6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698858389; x=1699463189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACtbDGuD6MnDLtRfrY8r3GOV1M4ngbjpcwXbhvL0euE=;
        b=DioFk9NaQgwh6gzeC8dKq4deLWskjL6cm8mAt51AO7LzN1u3FWeIlIyLckEPiXRQ4K
         Yp31R9KhJ2KTnzx4jiyYcojjSEfIQgpxrJ+SKRKhGAMEkLhbXdagwUM8AFtKqVpbdIZl
         NXzuTrIjkM8WoQHJztklf0EHFO5Nu5yPKw88s/BMSJ9si7E6Zjt91trSZQFXrJhBmg6/
         JOulpqRMPA4iKE9vd1bJ4/AqM5JAdfwmK7Qma4ia1wFd6jCuKCcZX8BJdQm7tkH0EHRr
         J5ksHEt0vumiuKgjy9t+PLPMfGNeW/BLBPLBhsAKNpnC5DSCa8lZiQsO9V12fwk9EozO
         DZqA==
X-Gm-Message-State: AOJu0YyZkhnzK7AJDZ98dVo7c/aeIBA5U7JdnegZJMEWIaOSOCe+ARdH
        CegNWqs7BTCCXrqOksPY1FIotQ==
X-Google-Smtp-Source: AGHT+IGDzF7Sr80/ji5fpFgmiXPcEYqf4bfWA92oba3hW5WW+ntNPgwDgNSORh/ITQ3cqqhDMxHbBw==
X-Received: by 2002:a17:902:d488:b0:1cc:5f5a:5d3 with SMTP id c8-20020a170902d48800b001cc5f5a05d3mr9031339plg.22.1698858389079;
        Wed, 01 Nov 2023 10:06:29 -0700 (PDT)
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id jh19-20020a170903329300b001c61df93afdsm1580553plb.59.2023.11.01.10.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 10:06:28 -0700 (PDT)
Date:   Wed, 1 Nov 2023 10:06:26 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        Xiao Wang <xiao.w.wang@intel.com>,
        Evan Green <evan@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v9 0/5] riscv: Add fine-tuned checksum functions
Message-ID: <ZUKFkn/PzOjw129p@ghost>
References: <20231031-optimize_checksum-v9-0-ea018e69b229@rivosinc.com>
 <20231101-palace-tightly-97a1d35a4597@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101-palace-tightly-97a1d35a4597@spud>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Nov 01, 2023 at 11:50:46AM +0000, Conor Dooley wrote:
> On Tue, Oct 31, 2023 at 05:18:50PM -0700, Charlie Jenkins wrote:
> > Each architecture generally implements fine-tuned checksum functions to
> > leverage the instruction set. This patch adds the main checksum
> > functions that are used in networking.
> > 
> > This patch takes heavy use of the Zbb extension using alternatives
> > patching.
> > 
> > To test this patch, enable the configs for KUNIT, then CHECKSUM_KUNIT
> > and RISCV_CHECKSUM_KUNIT.
> > 
> > I have attempted to make these functions as optimal as possible, but I
> > have not ran anything on actual riscv hardware. My performance testing
> > has been limited to inspecting the assembly, running the algorithms on
> > x86 hardware, and running in QEMU.
> > 
> > ip_fast_csum is a relatively small function so even though it is
> > possible to read 64 bits at a time on compatible hardware, the
> > bottleneck becomes the clean up and setup code so loading 32 bits at a
> > time is actually faster.
> > 
> > Relies on https://lore.kernel.org/lkml/20230920193801.3035093-1-evan@rivosinc.com/
> 
> I coulda sworn I reported build issues against the v8 of this series
> that are still present in this v9. For example:
> https://patchwork.kernel.org/project/linux-riscv/patch/20231031-optimize_checksum-v9-3-ea018e69b229@rivosinc.com/
> 
> Cheers,
> Conor.

You did, and I fixed the build issues. This is another instance of how
Patchwork reports the results of the previous build before the new build
completes. Patchwork was very far behind so it took around 15 hours for
the result to be ready. There are some miscellaneous warnings in random
drivers that I don't think can be attributed to this patch.

- Charlie

