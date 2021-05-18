Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD8A387205
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 08:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhERGkT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 02:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241297AbhERGkR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 May 2021 02:40:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED38AC061573;
        Mon, 17 May 2021 23:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WX0YUVYiarp6Ub0f2UiSDe+fbLD3ur/C0/1hpH2RgzE=; b=CM6dlAusPAZtazKdk+O8WqQtAf
        HPFcLwoy3Xcp3PaLBA278ffUKpHXNij+ynFUzVASB7Y9up8zD2LigYxcyWBmbywUgi6UlQMhjDL3O
        IYHmg6iASsduxcWwk3nr82FtSj4G7bVTEPPo96ld5A26UxlmuRnAK1xdgGZjmjYkSDDocE+VNbRMu
        0owxUEQR88oFKMMFXBdUUqla8q/NhbUtKg6IVyG+pLY6N+a8NibhP1B+BfmXDA0jQ6kTsQedz+Pt8
        DvjycQR+joViIkhOCm5f+Rv2I8JUCdYpPf50qHEgCKrQxk3J0pYsCWfl6XgkVCD+5LYABwJpopyS2
        F7Zy9K5g==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1litMl-00Difb-Uu; Tue, 18 May 2021 06:38:16 +0000
Date:   Tue, 18 May 2021 07:38:07 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        kexec@lists.infradead.org
Subject: Re: [PATCH v3 1/4] kexec: simplify compat_sys_kexec_load
Message-ID: <YKNgz7YaAq0awwNQ@infradead.org>
References: <20210517203343.3941777-1-arnd@kernel.org>
 <20210517203343.3941777-2-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517203343.3941777-2-arnd@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> +	if (in_compat_syscall())
> +		return copy_user_compat_segment_list(image, nr_segments, segments);

Annoying overly lone line here.

Otherwise:

Reviewed-by: Christoph Hellwig <hch@lst.de>

