Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4237DBB42
	for <lists+linux-arch@lfdr.de>; Mon, 30 Oct 2023 15:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjJ3OCH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Oct 2023 10:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbjJ3OCG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Oct 2023 10:02:06 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56122C0;
        Mon, 30 Oct 2023 07:02:04 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507a29c7eefso6462048e87.1;
        Mon, 30 Oct 2023 07:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698674522; x=1699279322; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pM4/raj46zgv4xk5bfFK6Dn9w2JTEPZCoW46aHiMDU=;
        b=lo5xzitVoDl3bDO8AE28X20iOU4RA6ev6TbRlJ6lgY2xD69mqH3pq3yY2y+zT2tZtK
         XBGMCfqNzkAGxna6uuyP0yD/4uizv+LPjv+5nzrvm4FKwiy3MjoZYuJEyyCVkGQgWuOY
         rRZpJx4EuYENRlJwS0Ld/1grl+2j3BJUeJFP5KQaIbkJ4TBmwjPSwGSGlTp3vYz3camK
         4PuXjjBo1b4N/QukKuoNuo8+U/Y5QUtwKfYRUSJ1yBC1IqrS2dLr3QDYh/FeJ9V0Nomc
         gC5b5cIaXinPbq3HbZTX5BlsOVbHjrqV0hQHl6Bp7BfqkEVlQDGV4Cz9eQ0vHl3n9GLc
         5QdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698674522; x=1699279322;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pM4/raj46zgv4xk5bfFK6Dn9w2JTEPZCoW46aHiMDU=;
        b=tOEQUFcSkBzgMIZAk4ek9X8yoEQEskK8R1nwhQy8gV/4X8RKnEyeKDq4YXgrVMLVwR
         GEVJ3Cs7p9r/yqnU+ExdBV9aYTE1nc1bTaaGZZEpp2HceYT7yJC1WIG2+m63FsUMDagB
         mWpJHXfeNt3no0hZ1An4qDqcNrBvhPAobl2ILfc3rhGfpStcrK2SP09L3aUPN3v6iQCR
         B75vCkc0EGAgUGML8x3pJHuKsCuBgqX0h32bhet9CP0Au7e9lNTfLYxGk3saMXanYD4d
         eGBRz8yjJh6/5yNcfRW+AbBfNjQo7DUFO7qjxu6FSh+8qjfKlAn1txgD2bPnuTbhaFYW
         F1rw==
X-Gm-Message-State: AOJu0YxKR/xG7w3ZRggmeAbWjCBH5tTMAI8tp6MmyS7/CzzzS9dLwEUW
        LPiE29JELkcN8wmDTY7YDoc=
X-Google-Smtp-Source: AGHT+IExXDR5h/gb2Xkd0IPxFcJr1nDMGyjwni4lSAmtf29yb2qVdb4yT3orag51W3s1lUikBA/nsQ==
X-Received: by 2002:a05:6512:3a96:b0:505:7896:18de with SMTP id q22-20020a0565123a9600b00505789618demr1445170lfu.45.1698674522086;
        Mon, 30 Oct 2023 07:02:02 -0700 (PDT)
Received: from smtpclient.apple ([77.137.74.70])
        by smtp.gmail.com with ESMTPSA id q3-20020adff503000000b0032d09f7a713sm8316888wro.18.2023.10.30.07.02.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Oct 2023 07:02:01 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH v6 0/4] riscv: tlb flush improvements
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20231030133027.19542-1-alexghiti@rivosinc.com>
Date:   Mon, 30 Oct 2023 16:01:48 +0200
Cc:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <24E0FC81-810E-44FD-9494-CA9374E495B5@gmail.com>
References: <20231030133027.19542-1-alexghiti@rivosinc.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


> On Oct 30, 2023, at 3:30 PM, Alexandre Ghiti <alexghiti@rivosinc.com> =
wrote:
>=20
> +			on_each_cpu_mask(cmask,
> +					 __ipi_flush_tlb_range_asid,
> +					 &ftd, 1);
>=20

Unrelated, but having fed on the stack might cause it to be unaligned to
the cacheline, which in x86 we have seen introduces some overhead.

Actually, it is best not to put it on the stack, if possible to reduce
cache traffic.

