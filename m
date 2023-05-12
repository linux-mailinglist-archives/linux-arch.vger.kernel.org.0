Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCE4700133
	for <lists+linux-arch@lfdr.de>; Fri, 12 May 2023 09:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240125AbjELHQq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 May 2023 03:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239943AbjELHQH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 May 2023 03:16:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2071100C4;
        Fri, 12 May 2023 00:14:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6B43F21ACB;
        Fri, 12 May 2023 07:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683875647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RcUdtUJi2PiQqtiCm7buM/8oG8q6kjEOFUqHBNaWTB0=;
        b=Nw0d3oFZxDSa7IfLjfDrSR+TzdkfKONkQW8fA2olBrfbE90iR66gp/gydm2oG515e8UXZH
        oS0iBpkmPtEFCOhAX76ee5UI2y7D9W16qvQh0uV0tOpfwnPgJ38EHcUZclwyC3+X6qQfou
        Qp1Znt2cgQGYdJFKjA1lfcO45eYUFWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683875647;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RcUdtUJi2PiQqtiCm7buM/8oG8q6kjEOFUqHBNaWTB0=;
        b=I+4xdyt5xiE4rAPr+mHysMDmE6WlFySs/2DEoM9e6vS/cd1kzU/0in5ohXcDT7Q3Kqw8XE
        0Uv1FzH1JAKbkvDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0424413499;
        Fri, 12 May 2023 07:14:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JFNHOz7nXWTqfAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 12 May 2023 07:14:06 +0000
Message-ID: <226e8c7c-2b61-02e8-c779-1c247b695fc2@suse.de>
Date:   Fri, 12 May 2023 09:14:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v6 1/6] fbdev/matrox: Remove trailing whitespaces
Content-Language: en-US
To:     Helge Deller <deller@gmx.de>, Sui Jingfeng <15330273260@189.cn>,
        geert@linux-m68k.org, javierm@redhat.com, daniel@ffwll.ch,
        vgupta@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
        davem@davemloft.net, arnd@arndb.de, sam@ravnborg.org
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org
References: <20230510110557.14343-1-tzimmermann@suse.de>
 <20230510110557.14343-2-tzimmermann@suse.de>
 <0e13efbf-9a48-6e70-fdf3-8290f28c6dc7@189.cn>
 <a2315b9a-0747-1f0f-1f0a-1c6773931db4@suse.de>
 <15fe1489-f0fa-bbf6-ec08-a270bd4f1559@gmx.de>
 <e7bd021c-1a6b-6e47-143a-36ae2fd2fe6b@suse.de>
 <1c7ca6d3-76d7-047b-42ac-716e12946f90@gmx.de>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <1c7ca6d3-76d7-047b-42ac-716e12946f90@gmx.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------CpjIwvptAxhso7bcVtW45TYd"
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------CpjIwvptAxhso7bcVtW45TYd
Content-Type: multipart/mixed; boundary="------------arN0JqGEEJ97vExxMBPaev5v";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Helge Deller <deller@gmx.de>, Sui Jingfeng <15330273260@189.cn>,
 geert@linux-m68k.org, javierm@redhat.com, daniel@ffwll.ch,
 vgupta@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
 davem@davemloft.net, arnd@arndb.de, sam@ravnborg.org
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-parisc@vger.kernel.org
Message-ID: <226e8c7c-2b61-02e8-c779-1c247b695fc2@suse.de>
Subject: Re: [PATCH v6 1/6] fbdev/matrox: Remove trailing whitespaces
References: <20230510110557.14343-1-tzimmermann@suse.de>
 <20230510110557.14343-2-tzimmermann@suse.de>
 <0e13efbf-9a48-6e70-fdf3-8290f28c6dc7@189.cn>
 <a2315b9a-0747-1f0f-1f0a-1c6773931db4@suse.de>
 <15fe1489-f0fa-bbf6-ec08-a270bd4f1559@gmx.de>
 <e7bd021c-1a6b-6e47-143a-36ae2fd2fe6b@suse.de>
 <1c7ca6d3-76d7-047b-42ac-716e12946f90@gmx.de>
In-Reply-To: <1c7ca6d3-76d7-047b-42ac-716e12946f90@gmx.de>

--------------arN0JqGEEJ97vExxMBPaev5v
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMTEuMDUuMjMgdW0gMTk6MDIgc2NocmllYiBIZWxnZSBEZWxsZXI6DQo+IE9u
IDUvMTEvMjMgMTY6MjcsIFRob21hcyBaaW1tZXJtYW5uIHdyb3RlOg0KPj4+PiBCdXQgdGhl
IHdvcmsgSSBkbyB3aXRoaW4gZmJkZXYgaXMgbW9zdGx5IGZvciBpbXByb3ZpbmcgRFJNLg0K
Pj4+DQo+Pj4gU3VyZS4NCj4+Pg0KPj4+PiBGb3IgdGhlDQo+Pj4+IG90aGVyIGlzc3VlcyBp
biB0aGlzIGZpbGUsIEkgZG9uJ3QgdGhpbmsgdGhhdCBtYXRyb3hmYiBzaG91bGQgZXZlbiBi
ZQ0KPj4+PiBhcm91bmQgYW55IGxvbmdlci4gRmJkZXYgaGFzIGJlZW4gZGVwcmVjYXRlZCBm
b3IgYSBsb25nIHRpbWUuIEJ1dCBhDQo+Pj4+IHNtYWxsIG51bWJlciBvZiBkcml2ZXJzIGFy
ZSBzdGlsbCBpbiB1c2UgYW5kIHdlIHN0aWxsIG5lZWQgaXRzDQo+Pj4+IGZyYW1lYnVmZmVy
IGNvbnNvbGUuIFNvIHNvbWVvbmUgc2hvdWxkIGVpdGhlciBwdXQgc2lnbmlmaWNhbnQgZWZm
b3J0DQo+Pj4+IGludG8gbWFpbnRhaW5pbmcgZmJkZXYsIG9yIGl0IHNob3VsZCBiZSBwaGFz
ZWQgb3V0LiBCdXQgbmVpdGhlciBpcw0KPj4+PiBoYXBwZW5pbmcuDQo+Pj4NCj4+PiBZb3Un
cmUgd3JvbmcuDQo+Pg0KPiANCj4+IEknbSBub3QuIEkgZG9uJ3QgY2xhaW0gdGhhdCB0aGVz
ZSBkcml2ZXJzIGFyZSBhbGwgYnJva2VuLiBCdXQgZmJkZXYNCj4+IGFzIGEgd2hvbGUgaXMg
Yml0LXJvdHRpbmcgYW5kIG5vIG9uZSBhdHRlbXB0cyB0byBhZGRyZXNzIHRoaXMuIFRoZXJl
DQo+PiBhcmUgc2V2ZXJhbCByZWNlbnQgZXhhbXBsZXMgb2YgdGhpczoNCj4+DQo+PiAqIEkg
cmVjZW50bHkgc2VuZCBvdXQgYSAxMDAtcGF0Y2hlcyBzZXJpZXMgdG8gaW1wcm92ZSBwYXJh
bWV0ZXINCj4+IHBhcnNpbmcgYW5kIGF2b2lkIG1lbW9yeSBsZWFrcy4gVGhhdCBnb3Qgc2hv
dCBkb3duLiBJIGRpZG4ndCBhdHRlbXB0DQo+PiB0byBzdXBwb3J0IHBhcmFtZXRlciBwYXJz
aW5nIGZvciBtb2R1bGUgYnVpbGRzLg0KPiANCj4gWW91ciB3b3JrIGlzIGFwcHJlY2lhdGVk
IGFuZCBpdCB3YXNuJ3Qgc2hvdCBkb3duLCBidXQgaXQgd2Fzbid0IHBlcmZlY3QgDQo+IGVp
dGhlci4NCj4gDQo+PiAqIFRoZXJlJ3MgYmVlbiBhIDE1LXlycyBvbGQgYnVnIGluIGZiZGV2
J3MgcmVhZC93cml0ZSB3aGVyZSB0aGV5DQo+PiByZXR1cm4gYW4gaW5jb3JyZWN0IHZhbHVl
Lg0KPiANCj4gPw0KDQpUaGlzIG9uZToNCg0KaHR0cHM6Ly9wYXRjaHdvcmsuZnJlZWRlc2t0
b3Aub3JnL3BhdGNoLzUzNDY2OC8/c2VyaWVzPTExNjkzMSZyZXY9Mg0KDQo+IA0KPj4gKiBT
ZWUgdGhlIG90aGVyIGRpc2N1c3Npb24gb24gdGhpcyBwYXRjaHNldCBvbiB0aGUgc3RhdGUg
b2YgaGl0ZmIuDQo+Pg0KPj4gKiBUaGUgZmJkZXYgY29kZSBJIHJlY2VudGx5IGNsZWFuZWQg
dXAgaGFkIGJ1Z3MgaW4gaG93IGl0IHVzZXMgc29tZQ0KPj4gb2YgZmJkZXYncyBiYXNpYyBi
dWlsZGluZyBibG9ja3MgKHNlZSB0aGUgc2NyZWVuX2Jhc2Uvc2NyZWVuX2J1ZmZlcg0KPj4g
Y29uZnVzaW9uKS4NCj4gDQo+IEFzIHlvdSBzYWlkLi4uIHNvbWUgKGxpdHRsZS11c2VkL291
dGRhdGVkKSBkcml2ZXJzIG1heSBoYXZlIGlzc3Vlcw0KPiB3aGljaCBvZiBjb3Vyc2Ugc2hv
dyB1cCBpZiBvbmUgc3RhcnRzIHRvIGNsZWFuIHVwLCBhcyB5b3UgZG8uDQo+IE9uIGEgcGVy
LWRyaXZlciBiYXNpcyBpdCBjYW4gbWFrZSBzZW5zZSB0byBkcm9wIGEgc3BlY2lmaWMgZHJp
dmVyLg0KPiANCj4+ICogPGFzbS1nZW5lcmljL2ZiLmg+IGhhcyBiZWVuIGluIHRoZSB0cmVl
IHNpbmNlIDIwMDkgYW5kIG5vIG9uZQ0KPj4gYXR0ZW1wdGVkIHRvIGluY2x1ZGUgaXQgdW50
aWwgbm93Lg0KPj4NCj4+IE5vbmUgb2YgdGhpcyBpcyBhIHNpZ24gb2YgZ29vZCBtYWludGVu
YW5jZS4NCg0KTGV0IG1lIGFkZCB0aGF0IEknbSBub3QgcG9pbnRpbmcgZmluZ2VycyBhdCBh
bnlvbmUuIEl0J3MganVzdCB0aGUgDQpjdXJyZW50IHN0YXR1cyBBRkFJQ1QuDQoNCj4+IEFz
IEkndmUgd29ya2VkIG9uIERSTSdzIGZiZGV2IGVtdWxhdGlvbiBhIGxvdCwgSSB0cnkgdG8g
YmUgYSBnb29kDQo+PiBrZXJuZWwgY2l0aXplbiBhbmQgY2xlYW4gdXAgaW4gZmJkZXYgYXMg
d2VsbCB3aGVuIEkgc2VlIGEgcHJvYmxlbS4+IA0KPj4gQnV0IEknZCByZWFsbHkgbGlrZSB0
byBzZWUgbW9zdCBvZiB0aGVzZSBkcml2ZXJzIGJlaW5nIG1vdmVkIGludG8NCj4+IHN0YWdp
bmcgYW5kIGRlbGV0ZWQgc29vbiBhZnRlcndhcmRzLiBVc2VycyB3aWxsIGNvbXBsYWluIGFi
b3V0IHRob3NlDQo+PiBkcml2ZXJzIHRoYXQgYXJlIHJlYWxseSBzdGlsbCByZXF1aXJlZC4g
VGhvc2UgbWlnaHQgYmUgd29ydGggdG8gc3BlbmQNCj4+IGVmZm9ydCBvbi4NCj4gDQo+IEkn
ZCByZWFsbHkgbGlrZSB0byBzZWUgYSB3YXkgZm9yd2FyZCBhbmQgZ2V0IHRoZSByZXF1aXJl
ZCBkcml2ZXJzIG92ZXIgdG8NCj4gRFJNLCBlLmcuIGJhc2VkIG9uIHlvdXIgc2ltcGxlZHJt
IGRyaXZlci4NCj4gSWYgdGhlcmUgaXMgYSB3YXkgdG8gZ2V0IGJhc2ljIG9uLXNjcmVlbiAy
RCBiaXRibHQgYW5kIGZpbGxyZWN0IHN1cHBvcnQsDQo+IGl0IHdvdWxkIGRyb3AgdGhlIG5l
ZWQgZm9yIG1vc3Qgb2YgdGhlIGZiZGV2IGRyaXZlcnMuDQo+IFRoZSBjdXJyZW50IHdheSBv
ZiBiaXRibHQnaW5nIGZyb20gYSBidWZmZXIgb24gcmVndWxhciBiYXNpcyBpc3RvbyBzbG93
IA0KPiBmb3Igc3VjaCBvbGRlciBjYXJkcy4gRXZlbiBvbiBuZXcgaGFyZHdhcmUgaW4gZW11
bGF0b3JzIHRoZXJlDQo+IGlzIGEgYmlnIHNsb3dkb3duIHZpc2libGUuDQoNCkknZCBiZSBo
YXBweSB0byB0cnkgdG8gZHJvcCB0aGUgdW51c2VkL29ic29sZXRlL2Jyb2tlbiBkcml2ZXJz
LiBGb3IgdGhlIA0KcmVzdCwgSSdkIGRlc2lnbmF0ZSBmYmRldiBhcyBhIGdyYXBoaWNzIGNv
bnNvbGUgZm9yIHN5c3RlbXMgd2l0aG91dCB0ZXh0IA0KbW9kZS4gSSB0aGluayB0aGF0IHdh
cyB0aGUgb3JpZ2luYWwgaW50ZW50aW9uLg0KDQo+IA0KPj4+IFlvdSBkb24ndCBtZW50aW9u
IHRoYXQgZm9yIG1vc3Qgb2xkZXIgbWFjaGluZXMgRFJNIGlzbid0IGFuDQo+Pj4gYWNjZXB0
YWJsZSB3YXkgdG8gZ28gZHVlIHRvIGl0J3MgbGltaXRhdGlvbnMsIGUuZy4gaXQncyBsb3ct
c3BlZWQNCj4+PiBkdWUgdG8gbWlzc2luZyAyRC1hY2NlbGVyYXRpb24gZm9yIG9sZGVyIGNh
cmRzIGFuZCBhbmQgaXQncw0KPj4+IGluY2FwYWJpbGl0eSB0byBjaGFuZ2Ugc2NyZWVuIHJl
c29sdXRpb24gYXQgcnVudGltZSAoanVzdCB0byBuYW1lDQo+Pj4gdHdvIG9mIHRoZSBiaWdn
ZXIgbGltaXRhdGlvbnMgaGVyZSkuDQo+Pg0KPj4gWW91IGNhbiBjaGFuZ2UgcmVzb2x1dGlv
biBhdCBydW50aW1lOyBqdXN0IG5vdCB0aHJvdWdoIGZiZGV2IGlvY3Rscy4NCj4+IFRoZXJl
J3Mgbm8gdGVjaG5pY2FsIGxpbWl0YXRpb24gaGVyZS4gTm8gb25lIGZvdW5kIGFueSB1c2Ug
Zm9yIHRoaXMsDQo+PiBzbyBpdCdzIG5vdCB0aGVyZS4NCj4gDQo+IGZiZGV2IGRyaXZlcnMg
d291bGQgbmVlZCB0aGF0IHdoZW4gcG9ydGVkIHRvIERSTS4NCg0KV2h5PyBVc2Vyc3BhY2Ug
d291bGQgdGhlbiBzaW1wbHkgdXNlIERSTSBpb2N0bHMgdG8gc2V0IHRoZSBkaXNwbGF5IG1v
ZGUuDQoNCj4+PiBTbywgdW5sZXNzIHdlIHNvbWVob3cgZmluZCBhIGdvb2Qgd2F5IHRvIG1v
dmUgc3VjaCBkcml2ZXJzIG92ZXIgdG8NCj4+PiBEUk0gKHdpdGggYSBzZXQgb2YgbWluaW1h
bCAyRCBhY2NlbGVyYXRpb24pLCB0aGV5IGFyZSBzdGlsbA0KPj4+IGltcG9ydGFudC4NCj4+
DQo+PiAyZCBhY2NlbGVyYXRpb24gaXMgbW9zdGx5IHVzZWZ1bCBmb3IgdGhlIGZyYW1lYnVm
ZmVyIGNvbnNvbGUuDQo+IA0KPiBhbmQgWDExDQo+IA0KPj4gWW91IGNhbg0KPj4gZG8gdGhh
dCB3aXRoIERSTSBhbmQgZHJpdmVycyBoYXZlIChub3V2ZWF1KS4gSXQganVzdCBkaWRuJ3Qg
bWFrZSBhDQo+PiBtZWFuaW5nZnVsIGRpZmZlcmVuY2UgaW4gbW9zdCBjYXNlcy4NCj4gDQo+
IGlmIG5vdXZlYXUgZ290IGl0LCBjYW4ndCBpdCBiZSBkb25lIGZvciBzaW1wbGVkcm0gaW4g
YSBnZW5lcmljIHdheSB0b28/DQoNClByb2JhYmx5IG5vLCBhcyBpdCBkZXBlbmRzIG9uIHRo
ZSBoYXJkd2FyZSBmZWF0dXJlcy4gVGhlIERSTSBkcml2ZXIgDQp3b3VsZCBoYXZlIHRvIGlt
cGxlbWVudCBpdCdzIG93biBmYmRldiBzdXBwb3J0LiBUaGF0J3Mgbm90IHRvbyANCmNvbXBs
aWNhdGVkLCBidXQgc3RpbGwgbm90IHBvcnRhYmxlIGFtb25nIGRyaXZlcnMuDQoNCj4gDQo+
Pj4gQWN0dWFsbHksIEkganVzdCBkaWQgdGVzdCBtYXRyb3hmYiBhbmQgcG0yZmIgc3VjY2Vz
c2Z1bGx5IGEgZmV3DQo+Pj4gZGF5cyBiYWNrLCBhbmQgdGhleSB3b3JrZWQuIEZvciBzb21l
IHNtYWxsZXIgaXNzdWVzIEkndmUgcHJlcGFyZWQNCj4+PiBwYXRjaGVzLCB3aGljaCBhcmUg
b24gaG9sZCBkdWUgY29uZmxpY3RzIHdpdGggeW91ciBsYXRlc3QNCj4+PiBmaWxlLW1vdmUt
YXJvdW5kLSBhbmQgd2hpdGVzcGFjZS1jaGFuZ2VzIHdoaWNoIGFyZSBwYXJ0bHkgaW4NCj4+
PiBkcm0tbWlzYy4gQW5kIEkgZG8gaGF2ZSBzb21lIHVwY29taW5nIGFkZGl0aW9uYWwgcGF0
Y2hlcyBmb3INCj4+PiBjb25zb2xlIHN1cHBvcnQuDQo+IA0KPiBIZWxnZQ0KDQotLSANClRo
b21hcyBaaW1tZXJtYW5uDQpHcmFwaGljcyBEcml2ZXIgRGV2ZWxvcGVyDQpTVVNFIFNvZnR3
YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgNCkZyYW5rZW5zdHJhc3NlIDE0NiwgOTA0NjEg
TnVlcm5iZXJnLCBHZXJtYW55DQpHRjogSXZvIFRvdGV2LCBBbmRyZXcgTXllcnMsIEFuZHJl
dyBNY0RvbmFsZCwgQm91ZGllbiBNb2VybWFuDQpIUkIgMzY4MDkgKEFHIE51ZXJuYmVyZykN
Cg==

--------------arN0JqGEEJ97vExxMBPaev5v--

--------------CpjIwvptAxhso7bcVtW45TYd
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmRd5z4FAwAAAAAACgkQlh/E3EQov+B5
Jw/8DTcD7AgKgsFpdF4cm40Pzgaqzq5MGz7PikuLGkWQAa8s9xMv3R5S9ZqOe34fjGFOkhZLxgFt
7NamEUbAbjrHOfJ497O2oS3QzIiizOJGGta7gkocMbKpufCliP9TVPsL8QM9LlYQBtpbDQ+R3x9B
mhxWNzAhg5zhAQmy43QKLGnIKjmf1wCM71p0z1hox/YB2fqNJPGrq/3jqgB1x77fkO6n6ut6iw0j
OyNFGVMlwHyurrjzZ4VzeXsxkuAe02BVWNxdbH6/Aq/bl+AIF9WqXVyYL2qFiSjbP8TiIpEmeXCI
+z8xleLPMbxhhDemjoBeEKHmiyKtBCgImDg/k9NdWvFD1KLXk9bhW9NEJWl97Po5hZ8Na46P8gvX
Y6HMAaoibsfPlw2V/3hE1nko3NtOPcxSAdAvmXWej1N3hQehoL/yy8PBDqBVppAu8syfzdufFJlY
SCKkKMIdFdQYyr3Bb4SoGVgSfxMXGUJGRk0yIIChiDNiWw+NvnN/Tmsr9xZWA7tosNJzZmmVdFEN
ZfWzekH5Sq6dHlIJRfTBnIzKfpiW7jlS9G7yXSo0srXgT9OTXfCpfRlEcWTOLeFMD4eo3eRqKtV8
Cnzzaaqktx4NEHpDBeUDNUt5bguFGClqz3sTPIxMtzvDhVhWfNn+GipP0hJPxAI87DuxDtpAUGfz
5P4=
=57wd
-----END PGP SIGNATURE-----

--------------CpjIwvptAxhso7bcVtW45TYd--
