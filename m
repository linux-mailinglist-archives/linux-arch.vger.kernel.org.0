Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40BCBD8E08
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2019 12:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbfJPKfn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Oct 2019 06:35:43 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35776 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729559AbfJPKfk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2019 06:35:40 -0400
Received: by mail-lf1-f68.google.com with SMTP id w6so17035434lfl.2
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2019 03:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TPx7rPA0Br+et5o6KmRStGO/myFB8ZhOgy82/e79ydg=;
        b=jw4mP6UxdbKOn1Ax/5Lz6J3Yf5tVdATs7EvlFAJS+GhYi7/834ey8w/GvLQpLeZVc7
         7Mb3IXhbnQSlm+QXZ3MZ+nckKcixkU87Dmfefg2Z9rz8pDIfZBDL+OES3N1PpeYo6xU8
         PNyU5vrMcL2T8PAlZ7u7qD0H1U6OF5fCcn7y7a3kIALA9Bqh1plMD2Y9HS6Mm00vbv7v
         xjKALcfBL8p4Z6xSJDAwiS4oeDHxeJA6eDNAP8saYrTaPW6uq2jHilKFYwB8ptI5KkAz
         zT8lgn8Vk55SVZ90xAYBKzEcFI76nh/U52ixpe6wlEk/hmGMD2fliIAFd31J/AcanEeZ
         Jw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TPx7rPA0Br+et5o6KmRStGO/myFB8ZhOgy82/e79ydg=;
        b=bQmlYaGh9J9keaAx6WYqgOcghUvr6MWKJcyhEHEyLcJEIIcWqrdpGKgoYT5QtCjeUr
         oDSmA4STDLTDa2/TpDHdo3NPIJQP1vRTgRJJuokLdHGflTayWJkTBcSGyObWVfsXNMFD
         V+V2eJgYMmMDYdEFcPTpz9qmzv//Pn0WQx2O0VvGen6yQgQsfxtbaBNuJNEPwyoAxLtf
         eWplEeHWVHZMc6IX18WkN51CCEX9/uhB6MPzh5HEfn265vH7T5ckSNelflaeAaxMf5Be
         KEflkXhuu4LOyyoiY/S825jVLvKvTR7ceRvW57yN2gmIGfqSXq98DQksu9ZqCDteF4Ek
         LBvA==
X-Gm-Message-State: APjAAAUV/em27xVy/d8xsuVgZ6CfjZAFvTO8xV1Cchucsxda6nMQgg6i
        9IX3oh1OS2dMm5c4fo/8qnQBQw==
X-Google-Smtp-Source: APXvYqwEBdxAChMVVBFlmc6eUXtVvNheuH3e0SluP3ca6bXyqt8wHnILm5brTVtYux5zecvFFwwvVw==
X-Received: by 2002:ac2:5dc2:: with SMTP id x2mr24763989lfq.38.1571222137941;
        Wed, 16 Oct 2019 03:35:37 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id k7sm5791404lja.19.2019.10.16.03.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 03:35:37 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id E4B6C101F90; Wed, 16 Oct 2019 13:35:37 +0300 (+03)
Date:   Wed, 16 Oct 2019 13:35:37 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 5/5] asm-generic/mm: stub out p{4,d}d_clear_bad() if
 __PAGETABLE_P{4,u}D_FOLDED
Message-ID: <20191016103537.oeanj7nh7u7yhk7l@box>
References: <20191015191926.9281-1-vgupta@synopsys.com>
 <20191015191926.9281-6-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015191926.9281-6-vgupta@synopsys.com>
User-Agent: NeoMutt/20180716
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There is couple of typos in the subject of the patch. It has to be

	[PATCH v2 5/5] asm-generic/mm: stub out p{4,u}d_clear_bad() if __PAGETABLE_P{4,U}D_FOLDED

Otherwise the patchset looks good to me. You can use my ACK for all
patches.

-- 
 Kirill A. Shutemov
