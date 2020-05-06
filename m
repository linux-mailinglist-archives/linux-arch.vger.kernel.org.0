Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A841C7DF6
	for <lists+linux-arch@lfdr.de>; Thu,  7 May 2020 01:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgEFXgW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 May 2020 19:36:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40929 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727121AbgEFXgW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 May 2020 19:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588808180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4GE42jOdua+ii9NEsVA32zpvW4/j25e1V7wWknNFBjw=;
        b=Ui8uf+RoBzW6RV4R/+cC/kMGHVA7Ys2YbpkdP+PpeIaW+xm6flAS+RIeN7EcMddhq8ZUC4
        jmrvg+hvj0KGwGHajGVWD9KruIf+/aYZDZqzEXi0SYgotk5qd887XZFbyYHZMsbOucpap9
        lYYL3INYTBhAMgP5/xEBrQXODZJC504=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-P-BrVCLeOZmYGn3Rw1NMCA-1; Wed, 06 May 2020 19:36:18 -0400
X-MC-Unique: P-BrVCLeOZmYGn3Rw1NMCA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C60A1835B40;
        Wed,  6 May 2020 23:36:16 +0000 (UTC)
Received: from optiplex-lnx (unknown [10.3.128.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C6C010013BD;
        Wed,  6 May 2020 23:36:14 +0000 (UTC)
Date:   Wed, 6 May 2020 19:36:11 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     cl@linux.com, akpm@linux-foundation.org, arnd@arndb.de,
        willy@infradead.org, keescook@chromium.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: expland documentation over __read_mostly
Message-ID: <20200506233611.GC205881@optiplex-lnx>
References: <20200506231353.32451-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506231353.32451-1-mcgrof@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 06, 2020 at 11:13:53PM +0000, Luis Chamberlain wrote:
> __read_mostly can easily be misused by folks, its not meant for
> just read-only data. There are performance reasons for using it, but
> we also don't provide any guidance about its use. Provide a bit more
> guidance over it use.
               s/it/its

same goes for the subject, as I think there is a minor typo: s/expland/expand

> 
> Acked-by: Christoph Lameter <cl@linux.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
> 
> I sent this 2 years ago, but it fell through the cracks. This time
> I'm adding Andrew Morton now, the fix0r-of-falling-through-the-cracks.
> 
> Resending as I just saw a patch which doesn't clearly justifiy the
> merits of the use of __read_mostly on it.
> 

That would be my fault! (sorry) given the rationale below, the patch I sent
really doesn't need the hint. Thanks for the extra bit of education here.

(not an excuse) In a glance over the source tree, though, it seems most 
of the hinting cases are doing it in the misguided way.


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
> + * execute a critial path. We should be mindful and selective of its use.
> + * ie: if you're going to use it please supply a *good* justification in your
> + * commit log
>   */
>  #ifndef __read_mostly
>  #define __read_mostly
> -- 
> 2.25.1
> 

Acked-by: Rafael Aquini <aquini@redhat.com>

