Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A647506053
	for <lists+linux-arch@lfdr.de>; Tue, 19 Apr 2022 01:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbiDRXo3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 Apr 2022 19:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiDRXo2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Apr 2022 19:44:28 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B101BEB4;
        Mon, 18 Apr 2022 16:41:47 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id u15so29551931ejf.11;
        Mon, 18 Apr 2022 16:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=oMbj/ngB4Xh3u5slAt5+IUuTIHe0QYck6hgIDhGGZyI=;
        b=Lw0HPpmEilJ7jamzGeotijctF5AHV80XNoUo8pNNvFpfqAW9qsRPm/r+bOi2tkAhr5
         1PPUiSSvi4JLJnb9CzZWaBxulsm8Sf5AnLlXUK54WZ1QIKpqyoLBl5i3HtqNle0zAKCs
         PNZvloGV6FslYHe8ECOL+8639jNU4zYpipxNpzmepXt8UtaovU3gsMifDRRnI3Z/1TuS
         f5p9a2xttlhYAVQQwRKk2KNF/TfO5BZ0qAIRJICKYXfuYmqphH3CzycrqYKxf8tSFDzG
         UPAHPqRub1d99fqAz2wFuB2Tf7s+HgWh/KGq2VGpMF8bcCgBhK1bmbrjyaya8b/kdHqU
         wgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=oMbj/ngB4Xh3u5slAt5+IUuTIHe0QYck6hgIDhGGZyI=;
        b=PKPk+JvVjaudtRZVNlLVw8YMPDIu9SfanzzaegG2A51j99U0Xg2WHhKNc5hYv450/S
         lqtEbyNwkw8/pnnuKM6+UP/lKEbRVs2q86nQOZ91UvLlzi4VUSQ8dnsi0PVjh4b77Ap/
         W2G6Js3EiAcG2ogMQZl3J5czG+l4VCfhIpapX+9CByJZtODtCBdmNr8jEzzEiemoW4yK
         R0F8jsnVrzUyibLmH3I/k+iHUlUMHl1bzViyiojbPDGEWmbP6x0O42gPB6viJO5HvVO3
         3LgkI3kQSvKh+FES3Kj8cf1f/A2mane9XmYHkQGpc1mrFc87T2hJa9+RJn53JJfCrhli
         befQ==
X-Gm-Message-State: AOAM5308rzPgTcZVXOAVQpW1G+WmNSDddCdLUH3fu5XEGZ4UuI36pfdQ
        F86OLcyUqwqsFvs7rkkwVWx7MwibRFQo1w==
X-Google-Smtp-Source: ABdhPJzskXbKBYI3v3yN/vt7djM1RFhBYN1rxNho2kAMhgGvPFd+6Xbx3xvzUB2PB+xvJucZdZvvcQ==
X-Received: by 2002:a17:906:1194:b0:6ec:8197:e892 with SMTP id n20-20020a170906119400b006ec8197e892mr10660456eja.84.1650325306122;
        Mon, 18 Apr 2022 16:41:46 -0700 (PDT)
Received: from anparri (host-82-53-3-95.retail.telecomitalia.it. [82.53.3.95])
        by smtp.gmail.com with ESMTPSA id fq6-20020a1709069d8600b006e891c0b7e0sm4979497ejc.129.2022.04.18.16.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 16:41:45 -0700 (PDT)
Date:   Tue, 19 Apr 2022 01:41:37 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V2 0/3] riscv: atomic: Optimize AMO instructions usage
Message-ID: <20220418234137.GA444607@anparri>
References: <20220412034957.1481088-1-guoren@kernel.org>
 <YlbwOG46mCR8Q5tJ@tardis>
 <CAJF2gTRws6RqKmJHBdKsycWSkFgYna_MocJ+qp3Z9r1v7mQzsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTRws6RqKmJHBdKsycWSkFgYna_MocJ+qp3Z9r1v7mQzsg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> > Seems to me that you are basically reverting 5ce6c1f3535f
> > ("riscv/atomic: Strengthen implementations with fences"). That commit
> > fixed an memory ordering issue, could you explain why the issue no
> > longer needs a fix?
> 
> I'm not reverting the prior patch, just optimizing it.
> 
> In RISC-V “A” Standard Extension for Atomic Instructions spec, it said:

With reference to the RISC-V herd specification at:

  https://github.com/riscv/riscv-isa-manual.git

the issue, better, lr-sc-aqrl-pair-vs-full-barrier seems to _no longer_
need a fix since commit:

  03a5e722fc0f ("Updates to the memory consistency model spec")

(here a template, to double check:

  https://github.com/litmus-tests/litmus-tests-riscv/blob/master/tests/non-mixed-size/HAND/LR-SC-NOT-FENCE.litmus )

I defer to Daniel/others for a "bi-section" of the prose specification.
;-)

  Andrea
