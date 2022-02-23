Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2644C1536
	for <lists+linux-arch@lfdr.de>; Wed, 23 Feb 2022 15:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239610AbiBWOQp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Feb 2022 09:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241462AbiBWOQo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Feb 2022 09:16:44 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492A0B1895;
        Wed, 23 Feb 2022 06:16:13 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id s1so11324393edd.13;
        Wed, 23 Feb 2022 06:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=It8FN98uI0gWCGpr8ZQrhbKJFnKd2KRuLbUsKftnJwM=;
        b=LmvVCjb48o8HIJVT5QTyy0/yIjciEfwEDu/z9oGeXQ248LxFopz+o55lzSIMSoCmyq
         uwW4RBcQyVquiMn9re741LXiUrgxumQxqgqW2Y493r6DNgZ+z/QYJW3jw43f9BmS8cW0
         7/h7GTB1JnnV/o+EL1rOBwR5aTFVSzcQJHeR8mRwMtXVPvsascPOr8BTGsM/WUrsF3qe
         /xRFbTBzG2C+VHPcF+8U02eONrOlBkUPD7ZUQtjXhC33Vdrr0xkeV13ODrfNRQhOnBLD
         uBVu5Rg9Rfj4Pou88JVQ22tc0C90yRZK0FfnMk2CKbZXYsAnGAM9qrVBvALvFtjLIpE6
         +e1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=It8FN98uI0gWCGpr8ZQrhbKJFnKd2KRuLbUsKftnJwM=;
        b=werjRJQrIKscsLz7xo/UIaMgJ3MHJaW9i4I2O8053cf7TRQjU24/IwGos0wPoLu/N2
         fdECQoJygYJgqgTnXaKRfgqzbW+GoYOgoPBt6hGTJjW3+SNgRUZkRkI/lbZ4Fs+qKAV8
         ZML8LNasI97W0Hw+UorLS7SOAoU8mLVkeTRpqRd7O6fkuLjPZOTPmMOSLXx586b9bMgq
         jOXWUneI3mL5zxuRWKkkQltwXf0zVZGq5KxnI49oIyXhkvFHuyuohsXukRti7zwCNtSH
         wYiQrtznXZWas9SLj5vmeHQssOAYdoLkQdeDsy+y+b95xRl+n5odznuhEO/fGn9DxT4o
         CWYw==
X-Gm-Message-State: AOAM532ws7Ssll/ZQabC/2ie2dalWnp7WtS/WDoEvZeyaXBqXC1X1/zI
        CWnDLvu0pG0EHJy7xJ3tNYXxXPyerpGTaVbgAFtibg==
X-Google-Smtp-Source: ABdhPJwdahiI1bqr8gpSBx8NAi2Lzg6slziDDB3cE7GLLOY2hzOjQ8G4BMmBxxL9seXUxUkbNGAHLg==
X-Received: by 2002:a05:6402:2709:b0:413:1871:3bc7 with SMTP id y9-20020a056402270900b0041318713bc7mr11991773edd.71.1645625771773;
        Wed, 23 Feb 2022 06:16:11 -0800 (PST)
Received: from smtpclient.apple (dhcp-077-250-038-153.chello.nl. [77.250.38.153])
        by smtp.gmail.com with ESMTPSA id r19sm1443051ejz.139.2022.02.23.06.16.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Feb 2022 06:16:11 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [RFC PATCH 03/13] usb: remove the usage of the list iterator
 after the loop
From:   Jakob <jakobkoschel@gmail.com>
In-Reply-To: <6DFD3D91-B82C-469C-8771-860C09BD8623@gmail.com>
Date:   Wed, 23 Feb 2022 15:16:09 +0100
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergman <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Transfer-Encoding: quoted-printable
Message-Id: <86C4CE7D-6D93-456B-AA82-F8ADEACA40B7@gmail.com>
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
 <20220217184829.1991035-4-jakobkoschel@gmail.com>
 <CAHk-=wg1RdFQ6OGb_H4ZJoUwEr-gk11QXeQx63n91m0tvVUdZw@mail.gmail.com>
 <6DFD3D91-B82C-469C-8771-860C09BD8623@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Note that I changed the location of the struct member 'req' in =
gr_request
to make this work. Instead of reshuffling struct members this can also =
be
introduced by simply adding new struct members in certain spots.
In other code locations with the same pattern I didn't have to do that.

Assuming '_req' passed to gr_dequeue() is located just past 'ep' on the
heap, the check could pass even though the list searched is completely
empty.

&req->req for the head element will be an out-of-bounds pointer
that by coincidence or heap massaging is where '_req' is located.

Even if the list is empty the list_for_each_entry() macro will do:

	pos =3D list_first_entry(head, typeof(*pos), member);

resolving all the macros (list_first_entry() etc) it will look like =
this:

	pos =3D container_of(head->next, typeof(*pos), member)

Since the list is empty head->next =3D=3D head and container_of() is =
called on something
that is *not* actually of type gr_request.

Next, the check if the end of the loop is hit is evaluated:

	!list_entry_is_head(pos, head, member);

which will stop the loop directly before executing a single iteration.

then using '&req->req' is some bogus pointer pointing just past the =
struct gr_ep,
where in this case '_req' is located.

The point I'm trying to make: it's probably not safe to rely on the =
compiler and
that everyone is aware of this risk when adding/removing/reordering =
struct members.


Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
drivers/usb/gadget/udc/gr_udc.c | 25 +++++++++++++++++++++++++
drivers/usb/gadget/udc/gr_udc.h |  2 +-
2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/gr_udc.c =
b/drivers/usb/gadget/udc/gr_udc.c
index 4b35739d3695..29c662f28428 100644
--- a/drivers/usb/gadget/udc/gr_udc.c
+++ b/drivers/usb/gadget/udc/gr_udc.c
@@ -1718,6 +1718,7 @@ static int gr_dequeue(struct usb_ep *_ep, struct =
usb_request *_req)
		ret =3D -EINVAL;
		goto out;
	}
+	printk(KERN_INFO "JKL: This does print, but shouldn't");

	if (list_first_entry(&ep->queue, struct gr_request, queue) =3D=3D =
req) {
		/* This request is currently being processed */
@@ -1739,6 +1740,30 @@ static int gr_dequeue(struct usb_ep *_ep, struct =
usb_request *_req)
	return ret;
}

+static int __init init_test_jkl3(void)
+{
+	struct gr_ep *ep;
+	struct gr_udc *dev;
+	struct usb_request *_req;
+	void *buffer;
+
+	/* assume the usb_request struct is located just after the 'ep' =
on the heap */
+	buffer =3D kzalloc(sizeof(struct gr_ep)+sizeof(struct =
usb_request), GFP_KERNEL);
+	ep =3D buffer;
+	_req =3D buffer+sizeof(struct gr_ep);
+
+	/* setup to call gr_dequeue() */
+	dev =3D kzalloc(sizeof(struct gr_udc), GFP_KERNEL);
+	ep->dev =3D dev;
+	ep->dev->driver =3D 1;
+	INIT_LIST_HEAD(&ep->queue); /* list is empty */
+
+	gr_dequeue(&ep->ep, _req);
+
+	return 0;
+}
+__initcall(init_test_jkl3);
+
/* Helper for gr_set_halt and gr_set_wedge */
static int gr_set_halt_wedge(struct usb_ep *_ep, int halt, int wedge)
{
diff --git a/drivers/usb/gadget/udc/gr_udc.h =
b/drivers/usb/gadget/udc/gr_udc.h
index 70134239179e..14a18d5b5cf8 100644
--- a/drivers/usb/gadget/udc/gr_udc.h
+++ b/drivers/usb/gadget/udc/gr_udc.h
@@ -159,7 +159,6 @@ struct gr_ep {
};

struct gr_request {
-	struct usb_request req;
	struct list_head queue;

	/* Chain of dma descriptors */
@@ -171,6 +170,7 @@ struct gr_request {
	u16 oddlen; /* Size of odd length tail if buffer length is "odd" =
*/

	u8 setup; /* Setup packet */
+	struct usb_request req;
};

enum gr_ep0state {
--=20
2.25.1
