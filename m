Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECE948074B
	for <lists+linux-arch@lfdr.de>; Tue, 28 Dec 2021 09:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbhL1IRq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Dec 2021 03:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhL1IRp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Dec 2021 03:17:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0992AC061574;
        Tue, 28 Dec 2021 00:17:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C31DFB81162;
        Tue, 28 Dec 2021 08:17:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE5BC36AE8;
        Tue, 28 Dec 2021 08:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640679462;
        bh=6V/mPY6g2RVrJ859O1hhAptFGU7EB3tYhvoaTL7suFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u8bPcC8Py2UrHh4nuBvcLx3OPPg1JpMwVwq9awnw3OPYUmJCx0u7qkcBRQFJj+rc1
         jHD8XbeKgw7R7dEzQtQPm+75l/HBYcjMc85SJuwX3G1pgFHoGAFW8jIOmdm1z2qRz4
         hWDg69i61kcll+XBLzGES7o+z6qsnD3/qhrMNiw8=
Date:   Tue, 28 Dec 2021 09:17:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        John Garry <john.garry@huawei.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org
Subject: Re: [RFC 30/32] /dev/port: don't compile file operations without
 CONFIG_DEVPORT
Message-ID: <YcrIHxTDipVNUuCA@kroah.com>
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
 <20211227164317.4146918-31-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227164317.4146918-31-schnelle@linux.ibm.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 27, 2021 at 05:43:15PM +0100, Niklas Schnelle wrote:
> In the future inb() and friends will not be available when compiling
> with CONFIG_HAS_IOPORT=n so we must only try to access them here if
> CONFIG_DEVPORT is set which depends on HAS_IOPORT.
> 
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/char/mem.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> index cc296f0823bd..c1373617153f 100644
> --- a/drivers/char/mem.c
> +++ b/drivers/char/mem.c
> @@ -402,6 +402,7 @@ static int mmap_mem(struct file *file, struct vm_area_struct *vma)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_DEVPORT
>  static ssize_t read_port(struct file *file, char __user *buf,
>  			 size_t count, loff_t *ppos)
>  {
> @@ -443,6 +444,7 @@ static ssize_t write_port(struct file *file, const char __user *buf,
>  	*ppos = i;
>  	return tmp-buf;
>  }
> +#endif
>  
>  static ssize_t read_null(struct file *file, char __user *buf,
>  			 size_t count, loff_t *ppos)
> @@ -665,12 +667,14 @@ static const struct file_operations null_fops = {
>  	.splice_write	= splice_write_null,
>  };
>  
> -static const struct file_operations __maybe_unused port_fops = {
> +#ifdef CONFIG_DEVPORT
> +static const struct file_operations port_fops = {
>  	.llseek		= memory_lseek,
>  	.read		= read_port,
>  	.write		= write_port,
>  	.open		= open_port,
>  };
> +#endif

Why is this #ifdef needed if it is already __maybe_unused?

In looking closer, this change could be taken now as the use of this
variable already is behind this same #ifdef statement, right?

thanks,

greg k-h
