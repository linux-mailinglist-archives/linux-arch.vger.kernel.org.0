Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1BF9100E65
	for <lists+linux-arch@lfdr.de>; Mon, 18 Nov 2019 22:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfKRVwc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 Nov 2019 16:52:32 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34305 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfKRVwc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Nov 2019 16:52:32 -0500
Received: by mail-wr1-f65.google.com with SMTP id e6so21397713wrw.1;
        Mon, 18 Nov 2019 13:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RFg17RVVONYlOMgS/v5AT5Q6B713XrluYPByCtEM3YQ=;
        b=CJolYGs0Qf/+JyoirAjBDN4t9ddPaPQC6l5G8NtNBjny2R7Iz14wqXq2DlwOpS2JbW
         /HzwMxzqHt6ojDsYc76Q/iq4UCW2un+aEyUAG8I25QG4kXt7+4fFGhZM2rMJDErZLxd/
         njjqAJEkOtkJ9CFUdxlerEepkmhn/ZDoQEdSk0iNslRpeTWiPCsrjpcF5A9dlf7QxjtR
         DJHhWmyW6t/tQ7sLc8ywvBPZnl8h5C3CteEmGe2CzigvCN3no6KDYT1WUgzf1As0ZrVT
         9CuKQJAzif0sJoY/GPQ/+t1z4rkSSUhyoGGpaTiqIh4+ZiK9sWxAjD5CRc+hUhrK2nzr
         AuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RFg17RVVONYlOMgS/v5AT5Q6B713XrluYPByCtEM3YQ=;
        b=LMPR0dq2BIwr9GK9ZEXger5taMWvAuZ3tPJJLmUBdgiIyhtr3f4aBebvdlSNu6pe08
         ad2SchLGeXZVZ+yJuqgk57fpghZzokPchy7XEziCvCkBH69EWccjxoOVFtOMRpZcZRvH
         aBBswovEHCVCX9pcx4QFijp4jxKC03drwN0GB1BdHH4KFUa1a6DxAU70X+zR1XO19rFy
         mHa0CDD7rdAfxhz4eGR0kr9w8N5xDGh4eDch6Y0ZLmP/0U5A2/9rhxQ8Wiydu9qz89LL
         W1iabgzCC6C0yF0CnJc3VbAqB/5cg/OEOSrIwh5Ncg9B72Jj8+NUA/lH7glRXQkCtGfI
         tZGw==
X-Gm-Message-State: APjAAAUerd6h06gInZs/ganaY7zx5quJNjlbVd/uzYf1cXKYmBPflyLy
        yWWoPKpn02QL+HbVHcTirnYeXb8=
X-Google-Smtp-Source: APXvYqz0HrUfdYTI5c1gDu9NFRnvGRkNfEQmND3aCFciylfs4FiKCe1Eg7A09WKxcCEs/scGoRkdSw==
X-Received: by 2002:adf:ea8d:: with SMTP id s13mr33327276wrm.366.1574113949897;
        Mon, 18 Nov 2019 13:52:29 -0800 (PST)
Received: from avx2 ([46.53.249.232])
        by smtp.gmail.com with ESMTPSA id a2sm21058093wrt.79.2019.11.18.13.52.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 13:52:29 -0800 (PST)
Date:   Tue, 19 Nov 2019 00:52:27 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        security@kernel.org, ben.dooks@codethink.co.uk
Subject: [PATCH] exec: warn if process starts with executable stack
Message-ID: <20191118215227.GA24536@avx2>
References: <20191118145114.GA9228@avx2>
 <20191118125457.778e44dfd4740d24795484c7@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191118125457.778e44dfd4740d24795484c7@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There were few episodes of silent downgrade to an executable stack:

1) linking innocent looking assembly file

	$ cat f.S
	.intel_syntax noprefix
	.text
	.globl f
	f:
	        ret

	$ cat main.c
	void f(void);
	int main(void)
	{
	        f();
	        return 0;
	}

	$ gcc main.c f.S
	$ readelf -l ./a.out
	  GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
                         0x0000000000000000 0x0000000000000000  RWE    0x10

2) converting C99 nested function into a closure
https://nullprogram.com/blog/2019/11/15/

	void intsort2(int *base, size_t nmemb, _Bool invert)
	{
	    int cmp(const void *a, const void *b)
	    {
	        int r = *(int *)a - *(int *)b;
	        return invert ? -r : r;
	    }
	    qsort(base, nmemb, sizeof(*base), cmp);
	}

will silently require stack trampolines while non-closure version will not.

While without a double this behaviour is documented somewhere, add a warning
so that developers and users can at least notice. After so many years of x86_64
having proper executable stack support it should not cause too much problems.

If the system is old or CPU is old, then there will be an early warning
against init and/or support personnel will write that "uh-oh, our Enterprise
Software absolutely requires executable stack" and close tickets and customers
will nod heads and life moves on.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/exec.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/fs/exec.c
+++ b/fs/exec.c
@@ -762,6 +762,11 @@ int setup_arg_pages(struct linux_binprm *bprm,
 		goto out_unlock;
 	BUG_ON(prev != vma);
 
+	if (vm_flags & VM_EXEC) {
+		pr_warn_once("process '%s'/%u started with executable stack\n",
+			     current->comm, current->pid);
+	}
+
 	/* Move stack pages down in memory. */
 	if (stack_shift) {
 		ret = shift_arg_pages(vma, stack_shift);
