Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF351C98AC
	for <lists+linux-arch@lfdr.de>; Thu,  7 May 2020 20:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgEGSEe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 May 2020 14:04:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24331 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgEGSEd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 May 2020 14:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588874671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aVlr0go0O97QccJtyz40igefS9Blw7pPEqjgMac+DVM=;
        b=epM5gyCGJzABhLeI+ZOrAc2sjMexjOgaeLyjTeJMG+J/lH8mlo6T5KpQWQt1226T80ik7y
        yE5MlsGfumgl0t1nRST8ddXU4Ho9MRJR9sTtx8lzDvYEr/FS3wAotovoCtEtkusDcjVl/M
        oOoBYDDUQvBLnoswkN4dJwnl2H8E6sE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-2Rl7Y8AMNGiXSJRh-oNJeA-1; Thu, 07 May 2020 14:04:28 -0400
X-MC-Unique: 2Rl7Y8AMNGiXSJRh-oNJeA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A57864A7A;
        Thu,  7 May 2020 18:04:26 +0000 (UTC)
Received: from optiplex-lnx (unknown [10.3.128.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 06EE260CCC;
        Thu,  7 May 2020 18:04:23 +0000 (UTC)
Date:   Thu, 7 May 2020 14:04:20 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     cl@linux.com, akpm@linux-foundation.org, arnd@arndb.de,
        willy@infradead.org, keescook@chromium.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: expand documentation over __read_mostly
Message-ID: <20200507180420.GE205881@optiplex-lnx>
References: <20200507161424.2584-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507161424.2584-1-mcgrof@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 07, 2020 at 04:14:24PM +0000, Luis Chamberlain wrote:
> __read_mostly can easily be misused by folks, its not meant for
> just read-only data. There are performance reasons for using it, but
> we also don't provide any guidance about its use. Provide a bit more
> guidance over its use.
> 
> Acked-by: Christoph Lameter <cl@linux.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
> 
> This v2 just has a few spelling fixes.
> 
>  include/linux/cache.h | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/cache.h b/include/linux/cache.h
> index 750621e41d1c..8106fb304fa7 100644
> --- a/include/linux/cache.h
> +++ b/include/linux/cache.h
> @@ -15,8 +15,14 @@
>  
>  /*
>   * __read_mostly is used to keep rarely changing variables out of frequently
> - * updated cachelines. If an architecture doesn't support it, ignore the
> - * hint.
> + * updated cachelines. Its use should be reserved for data that is used
> + * frequently in hot paths. Performance traces can help decide when to use
> + * this. You want __read_mostly data to be tightly packed, so that in the
> + * best case multiple frequently read variables for a hot path will be next
> + * to each other in order to reduce the number of cachelines needed to
> + * execute a critical path. We should be mindful and selective of its use.
> + * ie: if you're going to use it please supply a *good* justification in your
> + * commit log
>   */
>  #ifndef __read_mostly
>  #define __read_mostly
> -- 
> 2.25.1
> 
Acked-by: Rafael Aquini <aquini@redhat.com>

