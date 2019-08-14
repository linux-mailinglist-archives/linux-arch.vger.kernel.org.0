Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 167658D6F9
	for <lists+linux-arch@lfdr.de>; Wed, 14 Aug 2019 17:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfHNPLs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Aug 2019 11:11:48 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:38989 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfHNPLs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Aug 2019 11:11:48 -0400
Received: by mail-pl1-f172.google.com with SMTP id z3so4018009pln.6;
        Wed, 14 Aug 2019 08:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lGXfFGJZnK1jr5Ngw3MR8nQ8UJZHJY/G5diNeO4nASQ=;
        b=PLNj8uEXsHGaSSba/gvNuHc4FrU64PPgbAJYC4UcRUMpUlaUQEDWGrlsJ7zTN3BN/r
         QlC9XUijp7F2aSJKq7jPqza/8Bivj6iKkmCGD2ChHh5AeiT6my00qTbJimS1NhMwv0I/
         Omn2kgtqhNjJzh9gTL+Zf6c54bEZP2Xh5j/m479QZbS/9fzpcYCeN1SDbDbhyiBopuhh
         1rPKP+BUMDIJvOAL6QuLKe7mnqraR98kVC/4YdMYXP2KqSDGoflm/4K3fjjsnoDNVknr
         5fjq1x5odAmX5l6r7HRD4NiGFk14D9hOv8VFUhmFJM8xw4wLyOv1/VQ8pQ6n8Nsgsk+a
         7hlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lGXfFGJZnK1jr5Ngw3MR8nQ8UJZHJY/G5diNeO4nASQ=;
        b=EiIdIyIHY9V3YiFTQlBst5RmIRrvXloa3ZgSZmRP9TdajiDsjycR/SSwiREuGHv37o
         SZjT8atdx2uBQid8GeLL4Y7r+VJet6i1zvR0v83G6qZKwHa74JHxioPqfQFDDisqfdhi
         LIGGYnIaGGIQW1/E68aHSxqRkVhaNtNK1S1rgA6J7c5dk916nkI18LRQAQDAHz7bP4Pe
         jtnHWe4x/KH3Xo51rzbmjBlv9YnTd67HFPndomon5EdzlbGvJuf4k1j4qpTGsB60UaO9
         OJItPNlYCUpxQixSTDcKhhB+sXqIw9MYjpW4DvJQUU0IT0NWKXSAvRrA/0G0AsQxLhOG
         Hcqw==
X-Gm-Message-State: APjAAAVu1Y7EkMFO3kBXI7t++xBtLazF3LXxefoOyj8Z2tf20bOe1ytK
        DwmVb+ot9Yvx6I7lzxfk/e8=
X-Google-Smtp-Source: APXvYqwQP5IjmZq/rwp5P8+L5WgZvQXhcLU3Vo4GAEVZdHyuRjmC014cCTQwoY8WCqfwo7Oa+VPOMg==
X-Received: by 2002:a17:902:8696:: with SMTP id g22mr9860056plo.122.1565795507227;
        Wed, 14 Aug 2019 08:11:47 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id j10sm64556pfn.188.2019.08.14.08.11.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 08:11:46 -0700 (PDT)
Subject: [PATCH 0/2] tools/memory-model: Update comment of jugdelitmus.sh
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lustig <dlustig@nvidia.com>,
        Akira Yokosawa <akiyks@gmail.com>
References: <20190801222026.GA11315@linux.ibm.com>
 <20190801222056.12144-27-paulmck@linux.ibm.com>
 <beb07965-eb83-9cd1-2b49-cfc24928dce5@gmail.com>
 <20190812180649.GM28441@linux.ibm.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <277937a7-0f50-ec1c-09ec-95ffbf85541e@gmail.com>
Date:   Thu, 15 Aug 2019 00:11:36 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812180649.GM28441@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Paul,

I see some inconsistency between the header comment of judgelitmus.sh
and the updated script.

This patch set updates the header. It is relative to current lkmm-dev
of -rcu.

Patch 1/2 corresponds to ("tools/memory-model: Move from
.AArch64.litmus.out to .litmus.AArch.out").

Patch 2/2 corresponds to ("tools/memory-model: Add data-race
capabilities to judgelitmus.sh").

You should be able to use each patch as a fix-up commit respectively.
I'm OK either with them applied at the head of the branch or
with them merged into your commits.

        Thanks, Akira
--
Akira Yokosawa (2):
  tools/memory-model: Reflect updated file name convention in
    judgelitmus.sh
  tools/memory-model: Mention data-race capability in jugdelitmus.sh's
    header

 tools/memory-model/scripts/judgelitmus.sh | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

-- 
2.17.1


