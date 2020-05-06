Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599F41C7E1D
	for <lists+linux-arch@lfdr.de>; Thu,  7 May 2020 01:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgEFXoZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 May 2020 19:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgEFXoX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 May 2020 19:44:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2C4C061A0F;
        Wed,  6 May 2020 16:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/mIgTGO/dbbtNuGx6xEL3gZ3Gxe+0BqRQqEnfi2EvrU=; b=EmjLuqwPgUCgw+PduQdQGvAc6F
        8RvN0OMd262txn/v3xozbV5mjXZAZ6rCQZC3cNvUZ2mFgf/JKU1oKW5JwrU5cjEU4eMB3/iBXJtSy
        ah/w4vXzLDxyt3kNznHQgJsnu4U4L98lWOcT0+LeN48TBQDhBCFY2OjQkiMN36468bJk1jvI763E6
        /bnQ2krMT/MmesIi3aRQUgWGh4Pxcp7xZyOYlMI1N+B/lurfRWMbDn1vOKviHxhz3E4xCW0THPoqE
        nxrnx+MQIIf8e/qpZIu4+li5eHiXzV9iX5sbcP0UirRURAvOkeHy80LIh6VQNmkuA6taXENYu3eYU
        NhKf6Qgg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWTi3-00028N-2R; Wed, 06 May 2020 23:44:15 +0000
Date:   Wed, 6 May 2020 16:44:14 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     cl@linux.com, akpm@linux-foundation.org, arnd@arndb.de,
        aquini@redhat.com, keescook@chromium.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: expland documentation over __read_mostly
Message-ID: <20200506234414.GN16070@bombadil.infradead.org>
References: <20200506231353.32451-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506231353.32451-1-mcgrof@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 06, 2020 at 11:13:53PM +0000, Luis Chamberlain wrote:
> + * execute a critial path. We should be mindful and selective of its use.

"critical"

