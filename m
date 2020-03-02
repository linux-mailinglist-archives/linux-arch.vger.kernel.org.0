Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAFFC176449
	for <lists+linux-arch@lfdr.de>; Mon,  2 Mar 2020 20:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725446AbgCBTvU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Mar 2020 14:51:20 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44354 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbgCBTvT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Mar 2020 14:51:19 -0500
Received: by mail-pl1-f194.google.com with SMTP id d9so191198plo.11
        for <linux-arch@vger.kernel.org>; Mon, 02 Mar 2020 11:51:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XZilsPo1YLBK8E1Pw4dZTb4vWmludtCsaaSac/3MMDA=;
        b=iqQ8hal+hROLxOcxpjalquMKiu9woEIw6aXmWeG5vmM4DtlG7cp9r0y0+MtLLbq4ka
         NHV/lumgLEkHK0syYv0JVDxwPDf3/ar+XZvH2GnngUeMTxl6Qf1TsOHlhfvq/cpcXwCm
         xV4A8gw2L4p3ZaZ+2+n5Vwj4gQlqIocr+akhvfkhKnkH9AdU0ovA0nVg4kRz3ZEzNsxx
         PQtXtAAIRTnLdOjQjaqNzDQUSlDYe65i9c7p7IL4PUSyhqwTt04RO8o80dFXI1ioswKB
         TnrAS5MSKQ/oX33xcZjLfgdQM8FDg8ohDST8Qcnbst2bexBvuNqEF24+qLM1Bw2uGXBl
         dsUQ==
X-Gm-Message-State: ANhLgQ1V99+uTGCw4UQ60y7I6irn0GF+PsGMFyxVoK3fj8vTbWu9Xzgt
        GqzNTzQtxLtE5w1LU5nmBbE=
X-Google-Smtp-Source: ADFU+vuS0ADPbIa3jZAtxH/aZydWwHs+uUfQsj7YmFtYdS6DhQKs/Dg2ct3LeyPhDrcCzfEdr4nkUQ==
X-Received: by 2002:a17:90b:1256:: with SMTP id gx22mr102080pjb.94.1583178678241;
        Mon, 02 Mar 2020 11:51:18 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id t142sm13594209pgb.31.2020.03.02.11.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 11:51:16 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 410D3413C3; Mon,  2 Mar 2020 19:51:16 +0000 (UTC)
Date:   Mon, 2 Mar 2020 19:51:16 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     kunit-dev@googlegroups.com, Hajime Tazaki <thehajime@gmail.com>,
        Octavian Purdila <tavi.purdila@gmail.com>,
        David Gow <davidgow@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-um@lists.infradead.org,
        linux-arch@vger.kernel.org, Patrick Collins <pscollins@google.com>,
        Conrad Meyer <cem@FreeBSD.org>,
        Motomu Utsumi <motomuman@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        Petros Angelatos <petrosagg@gmail.com>,
        Yuan Liu <liuyuan@google.com>,
        Thomas Liebetraut <thomas@tommie-lie.de>,
        Mark Stillwell <mark@stillwell.me>,
        David Disseldorp <ddiss@suse.de>,
        linux-kernel-library@freelists.org,
        Luca Dariz <luca.dariz@gmail.com>
Subject: Re: [RFC v2 21/37] lkl tools: "boot" test
Message-ID: <20200302195116.GF11244@42.do-not-panic.com>
References: <fb0fcf4ffddaabc7eae82e25d7ec5ea9c37eb2ae.1573179553.git.thehajime@gmail.com>
 <20200123193315.132434-1-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123193315.132434-1-brendanhiggins@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 23, 2020 at 11:33:15AM -0800, Brendan Higgins wrote:
> Luis,
> 
> Does this kind of match what you were thinking with the syscall testing?

Without looking too deeply into the code, it seems to be the case.
Are you going to expose / port kunit to tools/ to allow usersapace
to run kunit tests?

> In any case, I am excited about this. Please keep me posted in the
> future!

Yes please Cc me too.

  Luis
