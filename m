Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6468E279B9F
	for <lists+linux-arch@lfdr.de>; Sat, 26 Sep 2020 19:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbgIZRu4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 26 Sep 2020 13:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729883AbgIZRuz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 26 Sep 2020 13:50:55 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F318C0613CE
        for <linux-arch@vger.kernel.org>; Sat, 26 Sep 2020 10:50:54 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d13so4958235pgl.6
        for <linux-arch@vger.kernel.org>; Sat, 26 Sep 2020 10:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=hTdWakHiHp9Vlr0UcT3ntAxXSZRAAFha6FtskJko8Jw=;
        b=YTQoH/ZPZdj0DZHE9slEFw8q8+yyJ9RzJbYifN3Ucgx/DTLM0FjB9VMp0WUnu8Fo4+
         PepP4szgSee/u9o/rZUz5w4EdvFNwMgZMo9tc36/8AbqiOwDHt9YGDBlUppMgJpBfzYg
         7AYr35Btmhq6fY/v1TxRh+eJI7r5vi/cmmXxwRzbSJABMWSkAqD6IFTaIS0HEHgp/Cfp
         tN55uKlV211JLSUPzCQU+lJ1q5hf4iMfO9eE6wAPjJetSUryuCCuOG3Th3Cb8D67Ylgp
         a08soHTvJAjhcXT3/C8o9EBOgZnEWPcMYHNgcsfXBIcjjylqjvM7KtPG4MQeXrBGk9Iq
         +Eeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=hTdWakHiHp9Vlr0UcT3ntAxXSZRAAFha6FtskJko8Jw=;
        b=OHI8q1N8/HRgESanfpXn9wvPwQ8ScXQNC7EgMFZo8dxAz3hI1EZFQP+VIkThIFUVS8
         OXHQYZn49CWK8ku9iCN70SYIH15051itVhYHZGmu07SSnXSf3AcnXRB3rf7/ynlTNa/2
         m6/4L1kk7HKSqRzTbwWkCmy/whUXhE9wiAdip1VpDnn57LPffQiSux+HCy8dOlR22lGz
         wAl5WdnXT1nDlygqNaJ8+9M/dI9wF0jQ3BsXhrNGxIf+0a4YXRdTYAU5IcunuSBHwm2b
         cXAuGto5LlB8YZqbAEtTqZGd2JIivoEXHhTQ0tEiBHkaBRT1VMvHZzMF6HRjOflhgq0P
         A83g==
X-Gm-Message-State: AOAM532SnGvvsZJbcdZWSCPHUUM5DPo5qemTEXVMbwssDLNf5Slvkkfh
        CQvC7Tx+MNmUZvVwGinQqtVMiJNANReCWrcx
X-Google-Smtp-Source: ABdhPJzfmrgaHodK6b5xlg8OXYJn9Q34MTXKO9hZBFMHRHq1Kp+6jQlqwc2rhCTpfcPOuGwpd2mh7A==
X-Received: by 2002:a63:6306:: with SMTP id x6mr3566849pgb.161.1601142653517;
        Sat, 26 Sep 2020 10:50:53 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id v10sm2328987pjf.34.2020.09.26.10.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 10:50:52 -0700 (PDT)
Date:   Sat, 26 Sep 2020 10:50:52 -0700 (PDT)
X-Google-Original-Date: Sat, 26 Sep 2020 10:50:51 PDT (-0700)
Subject:     Re: remove set_fs for riscv v2
In-Reply-To: <20200922043752.GA29151@lst.de>
CC:     Christoph Hellwig <hch@lst.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
        Arnd Bergmann <arnd@arndb.de>
Message-ID: <mhng-9b0b114e-a104-40b7-b4f5-ad64dbbbd5bd@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 21 Sep 2020 21:37:52 PDT (-0700), Christoph Hellwig wrote:
> Given tht we've not made much progress with the common branch,
> are you fine just picking this up through the riscv tree for 5.10?
>
> I'll defer other architectures that depend on the common changes to
> 5.11 then.

I'm OK taking it, but there's a few things I'd like to sort out.  IIRC I put it
on a temporary branch over here

    https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/log/?h=riscv-remove_set_fs

under the assumption it might get lost otherwise, but let me know if that's not
what you were looking for.

Arnd: Are you OK with the asm-generic stuff?  I couldn't find anything in my
mail history, so sorry if I just missed it.

Al: IIRC the plan here was to have me merge in a feature branch with this
stuff, but it'd have to be based on your for-next as there are some
dependencies over there.  I see 5ae4998b5d6f ("powerpc: remove address space
overrides using set_fs()") in vfs/for-next so I think we should be OK, but let
me know if I'm doing something wrong.

> On Wed, Sep 09, 2020 at 08:55:15AM +0200, Christoph Hellwig wrote:
>> now that we've sorted out a remaining issue base.set_fs should not
>> be rebased any more, so you could pull it into the riscv tree or a topic
>> branch.
>>
>> The first four patch should go into base.set_fs, though.  Arnd, can you
>> re-review the updated patches?
> ---end quoted text---
