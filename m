Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF17E31FFAB
	for <lists+linux-arch@lfdr.de>; Fri, 19 Feb 2021 21:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhBSUGf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Feb 2021 15:06:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57944 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229803AbhBSUGd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 19 Feb 2021 15:06:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613765106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RdrWHXNP81cMfcwVYdcPmRXG0LMOXCcx5D2s5+R9i9E=;
        b=GzLQ5nsRCsO/LGzymoklCo9Kn5gBnDPtXNNzxyrx3SMEs1fMBJCBXtUSY1Rwc2qxtuJYcL
        MaXdFZ+/PVSobrIWVgsZNd39aBIJeroNegCgc6xFGhZBYUyAs0aLuWpB6MarKpWNLt4F8i
        BX41FsCVzkFmcEuYmsuWPWwX8C0oiSk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-kbtrUWp-NLmwrTJzGZseGA-1; Fri, 19 Feb 2021 15:05:02 -0500
X-MC-Unique: kbtrUWp-NLmwrTJzGZseGA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E211F80364B;
        Fri, 19 Feb 2021 20:04:58 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BB7325D9C2;
        Fri, 19 Feb 2021 20:04:58 +0000 (UTC)
Received: from zmail19.collab.prod.int.phx2.redhat.com (zmail19.collab.prod.int.phx2.redhat.com [10.5.83.22])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 6DDEA4A7C6;
        Fri, 19 Feb 2021 20:04:58 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: base64
From:   David Hildenbrand <dhildenb@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH RFC] mm/madvise: introduce MADV_POPULATE to prefault/prealloc memory
Date:   Fri, 19 Feb 2021 15:04:58 -0500 (EST)
Message-Id: <382EFE9E-86CB-4C0C-B0C8-4EAE8A5281D9@redhat.com>
References: <20210219192310.GI6669@xz-x1>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>, Jann Horn <jannh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dave Hansen <dave.hansen@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Rik van Riel <riel@surriel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, linux-alpha@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org
In-Reply-To: <20210219192310.GI6669@xz-x1>
To:     Peter Xu <peterx@redhat.com>
Thread-Topic: mm/madvise: introduce MADV_POPULATE to prefault/prealloc memory
Thread-Index: 1GhocwMB+h3nwFkPzKnrEoxU5kTmpw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQo+IEFtIDE5LjAyLjIwMjEgdW0gMjA6MjMgc2NocmllYiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhh
dC5jb20+Og0KPiANCj4g77u/T24gRnJpLCBGZWIgMTksIDIwMjEgYXQgMDY6MTM6NDdQTSArMDEw
MCwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6DQo+Pj4gT24gMTkuMDIuMjEgMTc6MzEsIFBldGVy
IFh1IHdyb3RlOg0KPj4+IE9uIEZyaSwgRmViIDE5LCAyMDIxIGF0IDA5OjIwOjE2QU0gKzAxMDAs
IERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlOg0KPj4+PiBPbiAxOC4wMi4yMSAyMzo1OSwgUGV0ZXIg
WHUgd3JvdGU6DQo+Pj4+PiBIaSwgRGF2aWQsDQo+Pj4+PiANCj4+Pj4+IE9uIFdlZCwgRmViIDE3
LCAyMDIxIGF0IDA0OjQ4OjQ0UE0gKzAxMDAsIERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlOg0KPj4+
Pj4+IFdoZW4gd2UgbWFuYWdlIHNwYXJzZSBtZW1vcnkgbWFwcGluZ3MgZHluYW1pY2FsbHkgaW4g
dXNlciBzcGFjZSAtIGFsc28NCj4+Pj4+PiBzb21ldGltZXMgaW52b2x2aW5nIE1BRFZfTk9SRVNF
UlZFIC0gd2Ugd2FudCB0byBkeW5hbWljYWxseSBwb3B1bGF0ZS8NCj4+Pj4+PiBkaXNjYXJkIG1l
bW9yeSBpbnNpZGUgc3VjaCBhIHNwYXJzZSBtZW1vcnkgcmVnaW9uLiBFeGFtcGxlIHVzZXJzIGFy
ZQ0KPj4+Pj4+IGh5cGVydmlzb3JzIChlc3BlY2lhbGx5IGltcGxlbWVudGluZyBtZW1vcnkgYmFs
bG9vbmluZyBvciBzaW1pbGFyDQo+Pj4+Pj4gdGVjaG5vbG9naWVzIGxpa2UgdmlydGlvLW1lbSkg
YW5kIG1lbW9yeSBhbGxvY2F0b3JzLiBJbiBhZGRpdGlvbiwgd2Ugd2FudA0KPj4+Pj4+IHRvIGZh
aWwgaW4gYSBuaWNlIHdheSBpZiBwb3B1bGF0aW5nIGRvZXMgbm90IHN1Y2NlZWQgYmVjYXVzZSB3
ZSBhcmUgb3V0IG9mDQo+Pj4+Pj4gYmFja2VuZCBtZW1vcnkgKHdoaWNoIGNhbiBoYXBwZW4gZWFz
aWx5IHdpdGggZmlsZS1iYXNlZCBtYXBwaW5ncywNCj4+Pj4+PiBlc3BlY2lhbGx5IHRtcGZzIGFu
ZCBodWdldGxiZnMpLg0KPiANCj4gWzFdDQo+IA0KPj4+IEUuZy4sIGNhbiB3ZSBzaW1wbHkgYXNr
IHRoZSBrZXJuZWwgImhvdyBtdWNoIG1lbW9yeSB0aGlzIHByb2Nlc3MgY2FuIHN0aWxsDQo+Pj4g
YWxsb2NhdGUiLCB0aGVuIGdldCBhIG51bWJlciBvdXQgb2YgaXQ/ICBJJ20gbm90IHN1cmUgd2hl
dGhlciBpdCBjYW4gYmUgZG9uZQ0KPj4gDQo+PiBBbnl0aGluZyBsaWtlIHRoYXQgaXMgY29tcGxl
dGVseSByYWN5IGFuZCB1bnJlbGlhYmxlLg0KPiANCj4gVGhlIGZhaWx1cmUgcGF0aCB3b24ndCBi
ZSByYWN5IGltaG8gLSBJZiB3ZSBjYW4gZGV0ZWN0IGN1cnJlbnQgcHJvY2VzcyBkb2Vzbid0DQo+
IGhhdmUgZW5vdWdoIG1lbW9yeSBidWRnZXQsIGl0J2xsIGJlIG1vcmUgZWZmaWNpZW50IHRvIGZh
aWwgZXZlbiBiZWZvcmUgdHJ5aW5nDQo+IHRvIHBvcHVsYXRlIGFueSBtZW1vcnkgYW5kIHRoZW4g
ZHJvcCBwYXJ0IG9mIHRoZW0gYWdhaW4uDQo+IA0KPiBCdXQgSSBzZWUgeW91ciBwb2ludCAtIGlu
ZGVlZCBpdCdzIGdvb2QgdG8gZ3VhcmFudGVlIHRoZSBndWVzdCB3b24ndCBjcmFzaCBhdA0KPiBh
bnkgcG9pbnQgb2YgZnVydGhlciBndWVzdCBzaWRlIG1lbW9yeSBhY2Nlc3MuDQo+IA0KPiBBbm90
aGVyIHF1ZXN0aW9uOiBjYW4gdGhlIHVzZXIgYWN0dWFsbHkgc3BlY2lmeSBhcmJpdHJhcnkgbWF4
LWxlbmd0aCBmb3IgdGhlDQo+IHZpcnRpby1tZW0gZGV2aWNlICh3aGljaCBkZWNpZGVzIHRoZSBt
YXhpbXVtIG1lbW9yeSB0aGlzIGRldmljZSBjb3VsZCBwb3NzaWJseQ0KPiBjb25zdW1lKT8gIEkg
dGhvdWdodCB3ZSBzaG91bGQgY2hlY2sgdGhhdCBmaXJzdCBiZWZvcmUgcmVhbGl6aW5nIHRoZSBk
ZXZpY2UgYW5kDQo+IHdlIHJlYWxseSBzaG91bGRuJ3QgZmFpbCBhbnkgZ3Vlc3QgbWVtb3J5IGFj
Y2VzcyBpZiB0aGF0IGNoZWNrIHBhc3NlZC4gRmVlbA0KPiBmcmVlIHRvIGNvcnJlY3QgbWUuDQoN
Ck1heC1sZW5ndGggaXMgY3VycmVudGx5IGxpbWl0ZWQgYnkgdGhlIG1tYXAoKSB3ZeKAmHJlIGFs
bG93ZWQgdG8gY3JlYXRlLiBXaXRoIE1BUF9OT1JFU0VSVkUgdGhpcyBjYW4gYmUgYmlnIChub3Qg
bWVyZ2VkIHlldCkuDQoNCkNoZWNraW5nIG1heC1sZW5naHQgYXQgaW5pdGlhbGl6YXRpb24gdGlt
ZSBkb2VzIG5vdCBtYWtlIHRvbyBtdWNoIHNlbnNlLiBKdXN0IGltYWdpbmUgc2hyaW5raW5nL3Jl
bG9jYXRpbmcgb3RoZXIgVk1zIHNvIHlvdSBjYW4gZ3JvdyB0aGlzIFZNIGZ1cnRoZXIuIE9yIG1p
Z3JhdGluZyB0aGUgVk0gdG8gYW5vdGhlciBtYWNoaW5lIHdoZXJlIHlvdSBtaWdodCBncm93IGl0
IGZ1cnRoZXIuDQoNClRoZSB1bHRpbWF0ZSBnb2FsIGlzIHRvIGFkanVzdCB0aGUgbWFwcGluZyBz
aXplIGR5bmFtaWNhbGx5IG9uIGRlbWFuZCwgYnV0IHRoYXTigJhzIHN0dWZmIGZvciB0aGUgZnV0
dXJlIGFzIGl0IHR1cm5zIG91dCBjb21wbGljYXRlZC4gRm9yIGV4YW1wbGUsIGh1Z2V0bGJmcyBW
TUFzIGNhbm5vdCBiZSBtZXJnZWQgeWV0IChhbHRob3VnaCBJIHRoaW5rIGl0IHNob3VsZG7igJh0
IGJlIHRvbyBoYXJkIHRvIGltcGxlbWVudCkuDQoNClRoZSBzaG9ydCB0ZXJtIGFwcHJvYWNoIGlz
IG9ubHkgZXhwb3NpbmcgYSBzbWFsbCB3aW5kb3cgb2YgdGhlIGJpZ2dlciBtbWFwIHRvIHRoZSBn
dWVzdC4NCg0KPj4gDQo+PiBUaGF0IHdvdWxkIGJlIGtpbmQgb2Ygd2VpcmQuIEknZCBhc3N1bWUg
dGhlIHJlc2VydmF0aW9uIGdldHMgcHJvcGVybHkgZG9uZQ0KPj4gZHVyaW5nIGZvcmsoKSAtIGp1
c3QgbGlrZSBmb3IgVk1fQUNDT1VOVC4NCj4gDQo+IEFGQUlLIFZNX0FDQ09VTlQgaXMgbmV2ZXIg
YXBwbGllZCBmb3IgaHVnZXRsYmZzLiAgTmVpdGhlciBkbyBJIGtub3cgYW55DQo+IGFjY291bnRp
bmcgZG9uZSBmb3IgaHVnZXRsYmZzIGR1cmluZyBmb3JrKCksIGlmIG5vdCB0YWtpbmcgdGhlIHBp
bm5lZCBwYWdlcw0KPiBpbnRvIGFjY291bnQgLSB0aGF0IGlzIGRlZmluaXRlbHkgYSBzcGVjaWFs
IGNhc2UuDQo+IA0KDQpZZXMsIGl0IGlzbuKAmHQgLSBJIG1lYW50IOKAnmxpa2XigJwgYXMgaW4g
4oCec2ltaWxhciB0byBzd2FwIHJlc2VydmF0aW9u4oCcLg0KDQo+PiANCj4+PiBIb3dldmVyIHRo
YXQncyBkZWZpbml0ZWx5IG5vdCB0aGUgY2FzZSBmb3IgUUVNVSBzaW5jZSBRRU1VIHdvbid0IHdv
cmsgYXQgYWxsIGFzDQo+Pj4gbGF0ZSBhcyB0aGF0IHBvaW50Lg0KPj4+IA0KPj4+IElPVywgZm9y
IGh1Z2V0bGJmcyBJIGRvbid0IGtub3cgd2h5IHdlIG5lZWQgdG8gcG9wdWxhdGUgdGhlIHBhZ2Vz
IGF0IGFsbCBpZiB3ZQ0KPj4+IHNpbXBseSB3YW50IHRvIGtub3cgIndoZXRoZXIgd2UgZG8gc3Rp
bGwgaGF2ZSBlbm91Z2ggc3BhY2UiLi4gIEFuZCBJSVVDIDIpDQo+Pj4gYWJvdmUgaXMgdGhlIG1h
am9yIGlzc3VlIHlvdSdkIGxpa2UgdG8gc29sdmUgdG9vLg0KPj4gDQo+PiBUbyBhdm9pZCBwYWdl
IGZhdWx0cyBhdCBydW50aW1lIG9uIGFjY2VzcyBJIHRoaW5rLiBSZXNlcnZhdGlvbiA8PQ0KPj4g
UHJlYWxsb2NhdGlvbi4NCj4gDQo+IFllcy4gIEJlc2lkZXMgbXkgYWJvdmUgcXVlc3Rpb24gcmVn
YXJkaW5nIG1heC1sZW5ndGggb2YgdmlydGlvLW1lbSBkZXZpY2U6IHdlDQo+IGNhcmUgbW9zdCBh
Ym91dCBwcml2YXRlIG1hcHBpbmdzIG9mIGh1Z2V0bGJmcy9zaG1lbSBoZXJlLCBhbSBJIHJpZ2h0
Pw0KPiANCj4gSSdtIHRoaW5raW5nIHdoeSB3ZSdkIG5lZWQgTUFQX1BSSVZBVEUgb2YgdGhlc2Ug
YXQgYWxsIGZvciBWTSBjb250ZXh0Lg0KDQpPbmUgcmVhc29uIGlzIHRoYXQgTUFQX1NIQVJFRCBk
b2VzIG5vdCBzdXBwb3J0IG1iaW5kKCkgLSB3aGljaCBzaG91bGQgaW5jbHVkZSBodWdldGxiZnMu
IEkgZGlkIG5vdCBpbnZlc3RpZ2F0ZSBvdGhlciBzaWRlIGVmZmVjdHMgLyBwZXJmb3JtYW5jZSBj
b25zaWRlcmF0aW9ucyBvbiBhbGxvY2F0aW9uLg0KDQpTaW1pbGFybHksIGZhbGxvY2F0ZSgpIGRv
ZXMgbm90IHJlc3BlY3QvY2FyZSBhYm91dCBOVU1BLg0KDQooQW5kIHllcywgTlVNQSBmb3Igdmly
dGlvLW1lbSB3aWxsIGJlIGltcG9ydGFudCku

